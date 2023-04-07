#!/bin/bash

WORDPRESS_VERSION=$(/opt/elasticbeanstalk/bin/get-config environment -k WORDPRESS_VERSION)
WORDPRESS_ARCHIVE_NAME=wordpress-$WORDPRESS_VERSION-no-content.zip

wget -q https://downloads.wordpress.org/release/$WORDPRESS_ARCHIVE_NAME
unzip -q $WORDPRESS_ARCHIVE_NAME
rm $WORDPRESS_ARCHIVE_NAME
cd wordpress
CURRENT_WP_DIRECTORY=$(pwd)
chown -R webapp:webapp $CURRENT_WP_DIRECTORY/..
ln -s /wpcontents $CURRENT_WP_DIRECTORY/wp-content
chown webapp:webapp $CURRENT_WP_DIRECTORY/wp-content
mv $CURRENT_WP_DIRECTORY/* $CURRENT_WP_DIRECTORY/..
cd ..
rmdir $CURRENT_WP_DIRECTORY
chmod 0444 wp-config.php

echo 'WordPress installation and configuration is now completed.'