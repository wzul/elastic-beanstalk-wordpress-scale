#!/bin/bash

set -e

/bin/bash "/var/app/current/.platform/hooks/postdeploy/01_refresh_env_for_cli.sh"
