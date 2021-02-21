#!/bin/bash
sudo mv /home/kamera.reload.sh /home/PCUser/Schreibtisch
sudo mv /home/kamera.sh /home/PCUser/Schreibtisch
sudo chown user /home/PCUser/Schreibtisch/kamera.sh
sudo chown user /home/PCUser/Schreibtisch/kamera.reload.sh
sudo chgrp user /home/PCUser/Schreibtisch/kamera.sh
sudo chgrp user /home/PCUser/Schreibtisch/kamera.reload.sh
sudo chmod 777 /home/PCUser/Schreibtisch/kamera.sh
sudo chmod 777 /home/PCUser/Schreibtisch/kamera.reload.sh

#start benchmark
sudo bash /home/files/bench.sh
sudo rm -r /home/files

#remove crontab
sudo sed '$d' /var/spool/cron/crontabs/root > foo
sudo crontab foo
sudo rm foo
