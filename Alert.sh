#!/bin/bash
#Sacamos la RAM
log=$(free -m -h -t | grep T | awk '{ram_free=($3*100)/$2} END {print ram_free}')
#Sacamos la CPU
cpu=$(mpstat | head -n4 | tail -n1 | cut -d " " -f45)
let ram=100-$log
#Si el uso de la RAM es mayor al 80% y la CPU al 100% guardamos en un log lo que ha sucedido, los procesos que más espacio ocupan junto con la hora.
cpu=$(echo $cpu | cut -d, -f1)
if [ $ram -eq 100 ] || [ $cpu -ge 80 ]; then
    echo "El uso de la RAM o de la CPU se excedió">>/home/$USER/X2_Alert_log.txt
    ps aux --width 30 --sort -rss | head -n4>>/home/$USER/X2_Alert_log.txt
fi

exit 0
