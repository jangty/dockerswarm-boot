#!/bin/sh            

echo "##### Docker service rollback start ! #####"
docker service rollback %APPLICATION_NAME%_$1
echo "##### Docker service rollback compelete !!! #####"

