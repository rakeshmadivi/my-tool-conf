#!/bin/bash

install_cpupower()
{
  echo INSTALLING CPU Freq./Power Monitoring tools...
  sudo apt-get install linux-cpupower #(4.9.130-2)
  
  # Usable commands: cpupower, turbostat, x86_energy_perf_policy
}

# Syblings list using node ids and cpu number
echo $(for i in 0 1 2 3; do for j in `ls /sys/devices/system/node/node${i}/| grep cpu |head -n 6`;do cat /sys/devices/system/node/node${i}/${j}/topology/thread_siblings_list|cut -f1 -d",";done; done;)


