#!/bin/bash

#*********** Log *************
#17/01/2021
#postgres
#problema1: al correr al frente no encuentra "/var/lib/postgresql/data/postgresql.conf"
#problema2: al correr en background sale con exit(0)
#
#python
#problem1:
#
#General: one process needs to keep running on front

#found in https://docs.docker.com/config/containers/multi-service_container/
# Start the first process
#./my_first_process -D
./postgres_script.sh -D
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start postgres_process: $status"
  exit $status
fi

#necesita usuario normal para que corra postgres
#Start the second process
#./my_second_process -D
# CMD ["python3", "app.py"]

./pythonapp_script.sh -D
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start python_process: $status"
  exit $status
fi

# Naive check runs checks once a minute to see if either of the processes exited.
# This illustrates part of the heavy lifting you need to do if you want to run
# more than one service in a container. The container exits with an error
# if it detects that either of the processes has exited.
# Otherwise it loops forever, waking up every 60 seconds

#while sleep 60; do
  #ps aux |grep my_first_process |grep -q -v grep
  #PROCESS_1_STATUS=$?
  #ps aux |grep my_second_process |grep -q -v grep
  #PROCESS_2_STATUS=$?
  # If the greps above find anything, they exit with 0 status
  # If they are not both 0, then something is wrong
  #if [ $PROCESS_1_STATUS -ne 0 -o $PROCESS_2_STATUS -ne 0 ]; then
   # echo "One of the processes has already exited."
    #exit 1
  #fi
#done