#!/bin/bash

VNCPX=1440x900
echo "Setting password"
/bin/su -c "echo test123 | vncpasswd -f > /home/vncuser/.vnc/passwd" - vncuser
ls -la /home/vncuser/.vnc/

echo "Starting VNC Server on port 5901 "
#/bin/su -c "vncserver -depth 24 -geometry ${VNCPX} -localhost no" - vncuser
sleep infinity