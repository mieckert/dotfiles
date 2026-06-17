#!/bin/bash
# Get GPU utilization for Apple Silicon or Intel Macs
GPU_LOAD=$(ioreg -c IOAccelerator -d 2 -w 0 | grep -o '"Device Utilization"=[0-9]*' | cut -d= -f2 | head -n1)

if [ -z "$GPU_LOAD" ]; then
  echo "0%"
else
  echo "${GPU_LOAD}%"
fi
