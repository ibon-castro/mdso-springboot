#!/bin/bash

cd /home/ec2-user/app/target || exit

# Ensure any previous app is stopped (optional safety)
pkill -f 'java -jar prueba-0.0.1-SNAPSHOT.jar'

# Start the app
nohup java -jar prueba-0.0.1-SNAPSHOT.jar > app.log 2>&1 &

# Optional: Write the PID to a file for stop.sh
echo $! > app.pid
