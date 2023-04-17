#!/usr/bin/env bash
# Author:      FoxxMD <https://github.com/FoxxMD>
#
# Description: Configures EC2 machine to be able to send mail using SES
#
# Notes: This script assumes the use of an Amazon EC2 instance using an Amazon Linux AMI.
#        Check the prerequisites in the AWS documentation below before using.
#        https://docs.aws.amazon.com/ses/latest/DeveloperGuide/send-email-sendmail.html
#
#        The following environmental variables must be present:
#        MAIL_HOST         -> The SMTP server to use EX email-smtp.us-east-1.amazonaws.com
#        MAIL_USERNAME     -> Amazon SES username
#        MAIL_PASSWORD     -> Amazon SES password
#        MAIL_DOMAIN       -> Domain to send mail from. Must be qualified with Amazon SES

echo "Starting sendmail configuration"

# get environmental variables into a readable format
MAIL_HOST=$(/opt/elasticbeanstalk/bin/get-config environment -k MAIL_HOST)
MAIL_USERNAME=$(/opt/elasticbeanstalk/bin/get-config environment -k MAIL_USERNAME)
MAIL_PASSWORD=$(/opt/elasticbeanstalk/bin/get-config environment -k MAIL_PASSWORD)
MAIL_DOMAIN=$(/opt/elasticbeanstalk/bin/get-config environment -k MAIL_DOMAIN)

# check that all variables needs are present
if test "${MAIL_HOST+isset}" && test "${MAIL_USERNAME+isset}" && test "${MAIL_PASSWORD+isset}" && test "${MAIL_DOMAIN+isset}"
    then
        echo "Found all mail env vars, checking for existing sendmail configuration";

        HOST=${MAIL_HOST}
        USERNAME=${MAIL_USERNAME}
        PASSWORD=${MAIL_PASSWORD}
        FROM=${MAIL_DOMAIN}

        if grep -q "$HOST" /etc/mail/sendmail.mc; then
            echo "Found host in sendmail.mc, skipping configuration"
        else
            echo "Did not find host in sendmail.mc, continuing configuration"

            # make sure dependencies are installed
            yum -y install sendmail sendmail-cf m4 cyrus-sasl-plain

            echo "AuthInfo:$HOST \"U:root\" \"I:$USERNAME\" \"P:$PASSWORD\" \"M:LOGIN PLAIN\"" > /etc/mail/authinfo
            makemap hash /etc/mail/authinfo.db < /etc/mail/authinfo
            echo "Connect:$HOST RELAY" > /etc/mail/access
            makemap hash /etc/mail/access.db < /etc/mail/access

            cp /etc/mail/sendmail.mc /etc/mail/sendmail.mc_bak
            cp /etc/mail/sendmail.cf /etc/mail/sendmail.cf_bak

            FULLLINE="define(\`SMART_HOST', \`$HOST')dnl\ndefine(\`RELAY_MAILER',\`esmtp')dnl\ndefine(\`RELAY_MAILER_ARGS', \`TCP \$h 587')dnl\ndefine(\`confAUTH_MECHANISMS', \`LOGIN PLAIN')dnl\nFEATURE(\`authinfo', \`hash -o /etc/mail/authinfo.db')dnl\nMASQUERADE_AS(\`$FROM')dnl\nFEATURE(masquerade_envelope)dnl\nFEATURE(masquerade_entire_domain)dnl"
            awk -v line="$FULLLINE" '!found && /MAILER\(/ {print line; found=1 } 1' /etc/mail/sendmail.mc  > /etc/mail/sendmail_modified.mc
            cat /etc/mail/sendmail_modified.mc > /etc/mail/sendmail.mc

            chmod 666 /etc/mail/sendmail.cf
            m4 /etc/mail/sendmail.mc > /etc/mail/sendmail.cf
            chmod 644 /etc/mail/sendmail.cf
            /etc/init.d/sendmail restart

        fi;

        echo "Mail configuration complete"
    else
        echo "All mail env vars were not present, skipping configuration";
fi;

rm sendmailBashEnv