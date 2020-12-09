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


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
##echo $HAHA


#### DATE FORMAT 2020-12-04 ###
DT=`date '+%Y-%m-%d'`


##DIR="/home/mriantf/script_skripsi"
##WORKDIR="$DIR/script"
TMP="$DIR/tmp"

my_touch ${TMP}/list_report
/usr/bin/mysql -u dashadmin -p@BangJago10 -e "use dash_report;SELECT report_id, customer_name,customer_email,report_title,graph_type, rrd_name, rrd_title, periodic_graph
FROM reports
JOIN graphs ON graphs.id = reports.graph_id
JOIN users ON users.id = reports.user_id
JOIN customers ON customers.id = reports.customer_id
JOIN rrds ON rrds.report_id = reports.id
ORDER BY reports.id" | awk -F "\t" 'BEGIN{OFS=";"} {print $1,$2,$3,$4,$5,$6,$7,$8}'| grep -v "report_id;customer_name" >> ${TMP}/list_report

/usr/bin/bash ${DIR}/parseCsv.sh ${TMP}/list_report
