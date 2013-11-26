#!/bin/sh
# timesync.sh - ntp udpater via http.
# 
# Inside of vpn environment, we cannot connect to external ntp server because it' not using http port. 
# There're some ntp hosts that are providing ntp info via http. 
# This tool updates your local date via http. 
# You'll need root priviledge for updating.
#
# version: 0.0.1
# 2013, shinpei

# by default, we're using nict server.
# plase replace HTP_SERVER if you want to use others.

HTP_SERVER="http://ntp-a1.nict.go.jp/cgi-bin/time"

TIMEFILE="/tmp/ntpTime"
wget $HTP_SERVER -O $TIMEFILE > /dev/null 2>& 1
if [ $? -ne 0 ];then
    echo "Couldn't connect $HTP_SERVER, please check your network setting or site existense."
    exit 1
fi
TIME_STRING=`cat $TIMEFILE`
echo "Setting you time to"${TIME_STRING}
date -s "${TIME_STRING}"
if [ $? -ne 0 ]; then
    echo "Couldn't set time from stinrg, string="${TIME_STRING}
    exit 1
fi
rm $TIMEFILE
