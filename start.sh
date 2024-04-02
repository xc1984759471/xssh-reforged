#!/bin/bash
cd /root
source /app/config.sh
rm /etc/apt/apt.conf.d/76download
echo "Acquire

{
Queue-mode "access";

http

{
Dl-Limit "256";

};

https

{
Dl-Limit "256";

};
};" >> /etc/apt/apt.conf.d/76download
sed -i "s/deb.debian.org/mirrors.tuna.tsinghua.edu.cn/g" /etc/apt/sources.list
sed -i "s/security.debian.org/mirrors.tuna.tsinghua.edu.cn/g" /etc/apt/sources.list
sed -i "s/bullseye/stable/g" /etc/apt/sources.list
apt-get update 
apt-get upgrade -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold"
apt -y install git
git clone https://github.com/novnc/noVNC.git
apt -y install iperf locales locales-all xfce4-terminal tigervnc-standalone-server xfwm4 xxd python3 python3-pip dbus-x11 fonts-noto-cjk
#apt -y reinstall -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" $(apt-mark showmanual) $(apt-mark showauto)
mkdir /usr/share/locale/zh_CN
mkdir /usr/share/locale/zh_CN/LC_MESSAGES
mkdir /usr/share/locale/zh_CN/LC_TIME
locale-gen zh_CN.UTF-8
echo "export LANG=zh_CN.UTF-8" >> /root/.bashrc
echo "export LANG=zh_CN.UTF-8" >> /etc/profile
source /root/.bashrc
sed -i "s/256/128/g" /etc/apt/apt.conf.d/76download
pip3 install numpy
nohup iperf -s &
chmod +x /app/startvnc
/app/startvnc
cp -r /app/launch.sh /root/noVNC/utils
chmod +x /root/noVNC/utils/launch.sh
sleep 3
rm -rf novnc.log
bash -c "/root/noVNC/utils/launch.sh --listen 6080 --vnc $(hostname):5901 > novnc.log 2>&1 &"
sleep 1
cat novnc.log
service ssh start
service bt start
service nginx start
cat nohup.out
echo "set ngrok token: $NGROK_TOKEN"
ngrok authtoken $NGROK_TOKEN
echo "start ngrok service"
ngrok tcp 5901 --log=stdout > ngrok.log
