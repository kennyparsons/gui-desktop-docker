#FROM debian:buster-slim
FROM jgoerzen/debian-base-minimal

COPY scripts/ /opt/scripts/

RUN apt update \ 
  && apt install -y \
    apt-utils \
  && DEBIAN_FRONTEND=noninteractive apt install -y \
    wget \
    git \
    tigervnc-standalone-server \
    tigervnc-xorg-extension \
	tasksel \
	dialog \
  && DEBIAN_FRONTEND=noninteractive tasksel install desktop gnome-desktop \
  && useradd -ms /bin/bash vncuser \
  && mkdir -p /home/vncuser/.vnc/ \
  && mv /opt/scripts/xstartup /home/vncuser/.vnc \
  && chown -R vncuser:vncuser /home/vncuser/.vnc/ \
  && chmod +x /opt/scripts/*

ENTRYPOINT ["/bin/bash", "/opt/scripts/010.vncsetup.sh"]