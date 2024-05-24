#!/bin/bash

# the script starts with z so it is getting loaded after the www.conf
cat <<EOT > /etc/php-fpm.d/z-99-custom.conf
[www]
pm = ondemand
pm.max_children = 50
EOT