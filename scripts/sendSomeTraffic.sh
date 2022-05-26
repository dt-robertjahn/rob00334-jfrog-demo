#!/bin/bash

# This is a pipeline 'demo' script that sends a little traffic to the provided URL
# It is build specifically for the demo app within this repo
# It is intended to be run outside of a pipeline and can be stopped with 'ctrl-c'

URL=$1
if [ -z "$URL" ]
then
    echo "ERROR: URL arugment is required"
    exit 1
fi

if [ $# -eq 1 ]; then
  LOOPS=100
else
  LOOPS=$2
fi

echo "Calling $APP_URL"
echo "Number of Loops to run = $LOOPS"
for i in $(eval echo "{1..$LOOPS}"); 
  do
    echo "loop $i"
    curl -s -I -X GET "$URL/" | head -n 1 | cut -d$' ' -f2;
    curl -s -I -X GET "$URL/api/echo?text=Hello-World" | head -n 1 | cut -d$' ' -f2;
    curl -s -I -X GET "$URL/api/invoke?url=http://www.dynatrace.com" | head -n 1 | cut -d$' ' -f2;
    curl -s -I -X GET "$URL/api/invoke?url=http://blog.dynatrace.com" | head -n 1 | cut -d$' ' -f2;
done 
echo "Done"