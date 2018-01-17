#!/bin/bash

#command to launch pyspark using all processors and setting higher JVM memory limits

pyspark --master yarn --driver-memory 15g --num-executors 50 --executor-cores 4 --executor-memory 5g
