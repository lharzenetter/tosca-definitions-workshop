#!/bin/bash
cd /var/www/java/${AppName}

nohup java -jar ${AppName}.jar --server.port=$Port &>app.log &
