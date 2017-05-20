#!/bin/bash

DELAY=1

HOST=localhost
PORT=8088
URL=http://$HOST:$PORT
JSON_CONTENT_TYPE="content-type:application/json"

LED_PATH=led
MATRIX_PATH=matrix

MATRIX_PATTERN_RANDOM='{ "pattern": -1 }'
MATRIX_PATTERN_0='{ "pattern": 0 }'
MATRIX_PATTERN_1='{ "pattern": 1 }'
MATRIX_PATTERN_2='{ "pattern": 2 }'
MATRIX_PATTERN_3='{ "pattern": 3 }'
MATRIX_PATTERN_4='{ "pattern": 4 }'
MATRIX_PATTERN_5='{ "pattern": 5 }'

runDemo() {

  ## #######################################################################
  ## Toggle the single LED

  curl $URL/$LED_PATH -X POST -H "$JSON_CONTENT_TYPE" -d '{"value": 1}' 
  sleep $DELAY
  curl $URL/$LED_PATH -X POST -H "$JSON_CONTENT_TYPE" -d '{"value": 0}' 
  sleep $DELAY
  curl $URL/$LED_PATH -X POST -H "$JSON_CONTENT_TYPE" -d '{"value": 1}' 
  sleep $DELAY
  curl $URL/$LED_PATH -X POST -H "$JSON_CONTENT_TYPE" -d '{"value": 0}' 
  sleep $DELAY
  curl $URL/$LED_PATH -X POST -H "$JSON_CONTENT_TYPE" -d '{"value": 1}' 
  sleep $DELAY
  curl $URL/$LED_PATH -X POST -H "$JSON_CONTENT_TYPE" -d '{"value": 0}' 
  sleep $DELAY


  ## ########################################################################
  ## Play with the matrix
  
  curl $URL/$MATRIX_PATH -X POST -H "$JSON_CONTENT_TYPE" -d '{"pattern": 0, "brightness": 0}'
  sleep $DELAY
  
  curl $URL/$MATRIX_PATH -X POST -H "$JSON_CONTENT_TYPE" -d '{"pattern": 1, "brightness": 1}'
  sleep $DELAY
  
  curl $URL/$MATRIX_PATH -X POST -H "$JSON_CONTENT_TYPE" -d '{"pattern": 2, "brightness": 2}'
  sleep $DELAY
  
  curl $URL/$MATRIX_PATH -X POST -H "$JSON_CONTENT_TYPE" -d '{"pattern": 3, "brightness": 3}'
  sleep $DELAY
  
  curl $URL/$MATRIX_PATH -X POST -H "$JSON_CONTENT_TYPE" -d '{"pattern": 4, "brightness": 4}'
  sleep $DELAY
  
  curl $URL/$MATRIX_PATH -X POST -H "$JSON_CONTENT_TYPE" -d '{"pattern": 5, "brightness": 5}'
  sleep $DELAY
  
  curl $URL/$MATRIX_PATH -X POST -H "$JSON_CONTENT_TYPE" -d '{"pattern": 0, "brightness": 6}'
  sleep $DELAY
  
  curl $URL/$MATRIX_PATH -X POST -H "$JSON_CONTENT_TYPE" -d '{"pattern": 1, "brightness": 7}'
  sleep $DELAY
  
  curl $URL/$MATRIX_PATH -X POST -H "$JSON_CONTENT_TYPE" -d '{"pattern": 2}'
  sleep $DELAY
  
  curl $URL/$MATRIX_PATH -X POST -H "$JSON_CONTENT_TYPE" -d '{"pattern": 3}'
  sleep $DELAY
  
  curl $URL/$MATRIX_PATH -X POST -H "$JSON_CONTENT_TYPE" -d '{"pattern": 4}'
  sleep $DELAY
  
  curl $URL/$MATRIX_PATH -X POST -H "$JSON_CONTENT_TYPE" -d '{"pattern": 5}'
  sleep $DELAY
  
  curl $URL/$LED_PATH -X POST -H "$JSON_CONTENT_TYPE" -d '{"value": 1}' 
  
  curl $URL/$MATRIX_PATH -X POST -H "$JSON_CONTENT_TYPE" -d '{"pattern": -1, "brightness": 1}'
  sleep $DELAY
  
  curl $URL/$MATRIX_PATH -X POST -H "$JSON_CONTENT_TYPE" -d '{"pattern": -1, "brightness": 4}'
  sleep $DELAY
  
  curl $URL/$MATRIX_PATH -X POST -H "$JSON_CONTENT_TYPE" -d '{"pattern": -1, "brightness": 7}'
  sleep $DELAY
  
  curl $URL/$MATRIX_PATH -X POST -H "$JSON_CONTENT_TYPE" -d '{"pattern": -1, "brightness": 10}'
  sleep $DELAY
  
  curl $URL/$MATRIX_PATH -X POST -H "$JSON_CONTENT_TYPE" -d '{"pattern": -1, "brightness": 13}'
  sleep $DELAY
    
  curl $URL/$MATRIX_PATH -X POST -H "$JSON_CONTENT_TYPE" -d '{"pattern": -1, "brightness": 15}'
  
  curl $URL/$LED_PATH -X POST -H "$JSON_CONTENT_TYPE" -d '{"value": 0}' 
}

while true ; do
  runDemo
done

