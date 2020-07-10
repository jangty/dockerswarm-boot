#!/bin/sh
ABSOLUTE_PATH="$(cd $(dirname "$0") && pwd -P)"

cp $ABSOLUTE_PATH/.env_dev $ABSOLUTE_PATH/.env