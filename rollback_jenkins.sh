#!/bin/sh            

echo "##### Docker service rollback start ! #####"
docker service rollback %APPLICATION_NAME%
echo "##### Docker service rollback compelete !!! #####"

