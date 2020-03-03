#!/bin/bash
cd /var/www/java/${AppName}

# Inhibit some race condition
sleep 5

nohup java -jar ${AppName}.jar --server.port=$Port --logging.file=app.log &>/dev/null &

echo "Started Spring Web Application $AppName"
