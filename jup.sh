#!/bin/bash

#command to launch pyspark setting processor count and higher JVM memory limits

pyspark --master yarn --driver-memory 15g --num-executors 35 --executor-cores 4 --executor-memory 5g
