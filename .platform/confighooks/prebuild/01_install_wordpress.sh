#!/bin/bash

set -e

CURRENT_DIRECTORY=$(pwd)
/bin/bash $CURRENT_DIRECTORY/.platform/hooks/prebuild/01_install_wordpress.sh