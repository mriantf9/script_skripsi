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
TMP="$WORKDIR/tmp"
UNIQ=$1
DTL="${DIR}/REALTIME/data_list"

QUEUE="/var/www/html/skripsi/storage/app/realtime_task"

#rm -rf ${DIR}/REALTIME_QUEUE/*

cp ${QUEUE}/* ${DIR}/REALTIME_QUEUE/

ls ${DIR}/REALTIME_QUEUE > ${DIR}/REALTIME_QUEUE/tmp_list

for i in `cat ${DIR}/REALTIME_QUEUE/tmp_list`
do
    echo "Process Rsync ${i}"
    /usr/bin/rsync -r -av -e "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -p 22" ${DIR}/REALTIME_QUEUE/${i}  mriantf@27.131.3.177:${DTL}
done
