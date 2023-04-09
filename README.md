# WordPress High Availability with Elastic Beanstalk

Deploy WordPress to AWS Elastic Beanstalk with Nginx.

## Deploy instruction

Download this repository and upload to Elastic Beanstalk or zip:

```shell
zip ../wordpress-beanstalk.zip -r .ebextensions .platform wp-config.php
```

## System requirements

This WordPress running on Elastic Beanstalk requires:

- Amazon Elastic Filesystem (EFS)
- Relational Database (MySQL or MariaDB)

## Environment variables

This environment variables must be set in configuration:

### WordPress configuration

`AUTH_KEY`, `SECURE_AUTH_KEY`, `LOGGED_IN_KEY`, `NONCE_KEY`, `AUTH_SALT`, `SECURE_AUTH_SALT`, `LOGGED_IN_SALT`, `NONCE_SALT`, `WP_HOME`, `WP_SITEURL`

### WordPress database configuration

`RDS_DB_NAME`, `RDS_USERNAME`, `RDS_PASSWORD`, `RDS_HOSTNAME`, `RDS_PORT`

### Elastic Filesystem (EFS) configuration

`FILE_SYSTEM_ID`, `REGION`

## Cron jobs

WP Cron is disabled and executed by leader host

## Object cache and frontpage cache

It is recommended to use [Docket Cache](https://wordpress.org/plugins/docket-cache/) and [WP Super Cache](https://wordpress.org/plugins/wp-super-cache/). If you choose to utilize Docket Cache and WP Super Cache, be sure to add `DOCKET_CACHE` and `WP_SUPER_CACHE` keys in environment variables.

## Email sending

Refer to [Sendmail](https://github.com/wzul/sendmail-ses-elasticbeanstalk)