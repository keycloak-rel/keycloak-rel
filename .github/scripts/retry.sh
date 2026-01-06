#!/bin/bash

Command=${1:?Command is missing}
waitTime=${2:-30s}
repeat=${3:-20}

until eval $Command
do
  sleep $waitTime
  ((repeat--))
  if [ $repeat -lt 1 ]; then
    break;
  fi
done
