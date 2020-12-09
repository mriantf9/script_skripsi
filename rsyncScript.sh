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

#### DATE FORMAT 2020-12-04 ###
DT=`date '+%Y-%m-%d'`

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

WORKDIR="/home/mriantf/script_skripsi"
DT_REPORT="${WORKDIR}/DATA_REPORT"
SCHEDULE="${DT_REPORT}/scheduling"
LOG="${WORKDIR}/script/LOG_RSYNC"


LIST_REPORT=("Daily"
"Weekly"
"Monthly"
)


for i in "${LIST_REPORT[@]}"
do
  CSVFILE=`ls ${SCHEDULE}/${i}`
  for j in $CSVFILE
  do
    my_touch ${LOG}/${DT}_${j}.log
    #echo $j
	echo "Process Rsync ${i} File ${j}"
    /usr/bin/rsync -r -av -e "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -p 21021" ${SCHEDULE}/${i}  root@localhost:${DT_REPORT}/ >> ${LOG}/${DT}_${j}.log
  done
done




