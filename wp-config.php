<?php

if (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https')
    $_SERVER['HTTPS']='on';

define('DB_NAME',                       $_SERVER['RDS_DB_NAME']);
define('DB_USER',                       $_SERVER['RDS_USERNAME']);
define('DB_PASSWORD',                   $_SERVER['RDS_PASSWORD']);
define('DB_HOST',                       $_SERVER['RDS_HOSTNAME'] . ':' . $_SERVER['RDS_PORT']);
define('DB_CHARSET',                    'utf8');
define('DB_COLLATE',                    '');
define('AUTH_KEY',                      $_SERVER['AUTH_KEY']);
define('SECURE_AUTH_KEY',               $_SERVER['SECURE_AUTH_KEY']);
define('LOGGED_IN_KEY',                 $_SERVER['LOGGED_IN_KEY']);
define('NONCE_KEY',                     $_SERVER['NONCE_KEY']);
define('AUTH_SALT',                     $_SERVER['AUTH_SALT']);
define('SECURE_AUTH_SALT',              $_SERVER['SECURE_AUTH_SALT']);
define('LOGGED_IN_SALT',                $_SERVER['LOGGED_IN_SALT']);
define('NONCE_SALT',                    $_SERVER['NONCE_SALT']);
define('WP_HOME',                       $_SERVER['WP_HOME']);
define('WP_SITEURL',                    $_SERVER['WP_SITEURL']);

## EMAIL SES: INSTALL PLUGIN "OFFLOAD SES LITE"
define('WPOSES_AWS_ACCESS_KEY_ID',      $_SERVER['WPOSES_AWS_ACCESS_KEY_ID']);
define('WPOSES_AWS_SECRET_ACCESS_KEY',  $_SERVER['WPOSES_AWS_SECRET_ACCESS_KEY']);

define( 'AS3CF_SETTINGS', serialize( array(
	'provider' => 'aws',
	'access-key-id' => $_SERVER['S3_ACCESS_KEY'],
	'secret-access-key' => $_SERVER['S3_SECRET_ACCESS_KEY'],
) ) );
define('DISABLE_WP_CRON', true);

$table_prefix  = 'wp_';
define('WP_DEBUG', $_SERVER['WP_DEBUG'] == 'true');
define('WP_DEBUG_LOG', $_SERVER['WP_DEBUG_LOG'] == 'true');

if ( !defined('ABSPATH') ) {
  define('ABSPATH', dirname(__FILE__) . '/');
}
        
require_once(ABSPATH . 'wp-settings.php');
