#!/bin/bash
#


#### function my_touch() ###
my_touch() {
 if test -f $1
 then
  rm -f $1
  touch $1
 else
  touch $1
 fi
}


##HAHA="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
##echo $HAHA


LIST_REPORT=("Daily"
"Weekly"
"Monthly"
)


#### DATE FORMAT 2020-12-04 ###
DT=`date '+%Y-%m-%d'`


LIST_RP=$1

DIR="/home/mriantf/script_skripsi"
WORKDIR="$DIR/script"
TMP="$WORKDIR/tmp"
DTRP="$DIR/DATA_REPORT"
SCHEDULE="$DTRP/scheduling"


rm -rf ${SCHEDULE}/Daily/*
rm -rf ${SCHEDULE}/Weekly/*
rm -rf ${SCHEDULE}/Monthly/*

for i in "${LIST_REPORT[@]}"
do
	cat $LIST_RP |  grep ";${i};" | awk -F';' 'BEGIN{OFS=";"} {print $1,$4,$5,$2}' | sort -u | while read line
	do
		#echo "${line}"
		IDREPORT=`echo $line | awk -F';' '{print $1}'`
		GTYPE=`echo $line | awk -F';' '{print $3}'`
		REPORT_NAME=`echo $line | awk -F';' '{print $2}' | sed 's/ /_/g'`
		CUSTOMER_NAME=`echo $line | awk -F';' '{print $4}' | sed 's/ /_/g'`
		while read j
		do
		  IDREPORT2=`echo $j | awk -F';' '{print $1}'`
		  GTYPE2=`echo $line | awk -F';' '{print $3}'`
		  if [ "$IDREPORT" == "$IDREPORT2" ] && [ "$GTYPE" == "$GTYPE2" ]
		  then
		    echo "parshing proccess ReportID_${IDREPORT}_${CUSTOMER_NAME}_${GTYPE}.csv"
			
		    echo ${j} >> ${SCHEDULE}/${GTYPE}/ReportID_${IDREPORT}_${CUSTOMER_NAME}_${GTYPE}.csv
		  fi
		done < $LIST_RP
	done
done
