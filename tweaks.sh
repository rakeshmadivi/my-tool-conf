#!/bin/bash

install_cpupower()
{
  echo INSTALLING CPU Freq./Power Monitoring tools...
  sudo apt-get install linux-cpupower #(4.9.130-2)
  
  # Usable commands: cpupower, turbostat, x86_energy_perf_policy
}

# Syblings list using node ids and cpu number
echo $(for i in 0 1 2 3; do for j in `ls /sys/devices/system/node/node${i}/| grep cpu |head -n 6`;do cat /sys/devices/system/node/node${i}/${j}/topology/thread_siblings_list|cut -f1 -d",";done; done;)

function rows2cols()
{
  dfile=all_iops.txt
  for i in `seq 1 5`;do export val="";for j in 4k 8k 16k 32k 64k 128k 1024k;do iops=`grep "100 ${j} ${i}" $dfile |awk '{print $4}'`;export val="${val} ${iops}";done;echo ${i} $val;done;
  
  # Average
  for i in 0 5 35 50 65 95 100;do for j in 4k 8k 16k 32k 64k 128k 1024k;do echo ${i}_${j};grep "^${i} ${j}" all_data.txt| awk '{if(NF==4){sum+=$4}else if(NF==5){sum+=$5}}END{print sum / NR}';done;done
  
  # Averages
  for i in 100 95 65 50 35 5 0; do for j in 4k 8k 16k 32k 64k 128k 1024k; do echo "${i} ${j} `grep "^${i} ${j}" onlywrites.txt|awk '{sum+=$4}' END {print sum / NR}`";done;done; > averages.txt
  
  # Formatted for excel sheet
  for i in 100 95 65 50 35 5 0; do echo -n "${i},";echo $(grep "^${i} " averages.txt|awk '{print $3}')|sed 's/ /,/g';done > formatted.txt
}
