#!/bin/sh
cd /opt/solo/ && nohup java -cp WEB-INF/lib/*:WEB-INF/classes org.b3log.solo.Starter --listen_port=8080 --server_scheme=https --server_host=zhoujin7.com --server_port=  > /opt/solo/solo.log 2>&1 &
