#!/bin/bash
# Check if the application is running
if [ -f /home/ec2-user/app/target/app.pid ]; then
  PID=$(cat /home/ec2-user/app/target/app.pid)
  if ps -p $PID > /dev/null; then
    echo "Stopping application..."
    kill $PID
    sleep 5
  else
    echo "Process not running but PID file exists. Cleaning up."
  fi
  rm -f /home/ec2-user/app/target/app.pid
else
  echo "No PID file found. Application may not be running."
  # Try to kill any matching process just in case
  pkill -f 'java -jar prueba-0.0.1-SNAPSHOT.jar' || true
fi
exit 0
