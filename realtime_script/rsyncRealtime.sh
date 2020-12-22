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
WORKDIR="${DIR}/script"
QDTL="${DIR}/REALTIME_QUEUE/data_list"
DTL="${DIR}/REALTIME/data_list"

QUEUE="/var/www/html/skripsi/storage/app/realtime_task"

rm -rf ${QDTL}/*

#mv ${QUEUE}/${FILENAME} ${DIR}/REALTIME_QUEUE/${FILENAME}

ls ${QUEUE} > ${DIR}/REALTIME_QUEUE/tmp_list

for i in `cat ${DIR}/REALTIME_QUEUE/tmp_list`
do
    while IFS='' read -r line || [ "$line" ]
    do
        echo "Move ${i} to ${QDTL}"
        echo "$line" >> ${QDTL}/${i}
        rm -rf ${QUEUE}/${i}

        echo "process rsync ${i} ..."
        /usr/bin/rsync -r -av -e "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -p 22" ${DIR}/REALTIME_QUEUE/data_list/${i}  mriantf@27.131.3.177:${DTL}
    done < ${QUEUE}/${i}
done

rm -rf ${DIR}/REALTIME_QUEUE/tmp_list
