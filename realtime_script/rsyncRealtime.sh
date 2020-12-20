#!/bin/bash

my_touch() {
 if test -f $1
 then
  rm -f $1
  touch $1
 else
  touch $1
 fi
}


DIR="/home/mriantf/script_skripsi"
WORKDIR="$DIR/script"
UNIQ=$1
FILENAME=$2
DTL="${DIR}/REALTIME/data_list"

QUEUE="/var/www/html/skripsi/storage/app/realtime_task"

rm -rf ${DIR}/REALTIME_QUEUE/data_list/*

#mv ${QUEUE}/${FILENAME} ${DIR}/REALTIME_QUEUE/${FILENAME}

ls ${QUEUE} > ${DIR}/REALTIME_QUEUE/tmp_list

for i in `cat ${DIR}/REALTIME_QUEUE/tmp_list`
do
    echo "moving file ${i} into ${DIR}/REALTIME_QUEUE/data_list/${i}"
    mv ${QUEUE}/${i} ${DIR}/REALTIME_QUEUE/data_list/${i}
    echo "Process Rsync ${i}"
    /usr/bin/rsync -r -av -e "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -p 22" ${DIR}/REALTIME_QUEUE/data_list/${i}  mriantf@27.131.3.177:${DTL}
done

rm -rf ${DIR}/REALTIME_QUEUE/tmp_list

