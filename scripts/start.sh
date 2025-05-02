#!/bin/bash
cd /home/ec2-user/app
nohup java -jar my-app.jar > app.log 2>&1 &
