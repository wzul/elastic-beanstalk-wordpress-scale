#!/bin/bash

set -e

CURRENT_DIRECTORY=$(pwd)
/bin/bash $CURRENT_DIRECTORY/.platform/hooks/postdeploy/01_refresh_env_for_cli.sh