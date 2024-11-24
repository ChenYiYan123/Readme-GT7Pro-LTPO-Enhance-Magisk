#!/system/bin/sh


BASEDIR="$(dirname $(readlink -f "$0"))"

function boot(){
while true;
do
btcplt=$(getprop vendor.oplus.boot_complete)
if [ "$btcplt" -eq "1" ];then
	return 0
fi
sleep 1
done
}

#settings put system peak_refresh_rate 120.1
#settings put system min_refresh_rate 120.1

boot

#settings put system peak_refresh_rate 120.1
#settings put system min_refresh_rate 120.1

#sleep 5
#sh $BASEDIR/sceen_on_shell.rc

#添加其他通用shell 命令
