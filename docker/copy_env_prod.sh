#!/bin/sh
ABSOLUTE_PATH="$(cd $(dirname "$0") && pwd -P)"

cp $ABSOLUTE_PATH/.env_prod $ABSOLUTE_PATH/.env