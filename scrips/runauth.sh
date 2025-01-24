!/bin/bash

port_process=$(lsof -i:8080 | grep LISTEN | awk '{print $2}')
jarfile=$(ls *.jar 2>/dev/null | head -n 1)

if [ -z "$port_process" ]; then
    echo "Port 8080 is not in use"
else
    echo "Port 8080 is in use by process $port_process"
    kill -9 $port_process
fi


if [ -n "$jarfile" ]; then 
    echo "Running $jarfile"
    nohup java -jar $jarfile > ./auth_server.log 2>&1 &
    echo "Server started"
    tail -f ./auth_server.log 
else
    echo "No jar file found"
fi