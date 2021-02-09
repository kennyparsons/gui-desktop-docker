#FROM debian:buster-slim
FROM jgoerzen/debian-base-minimal

COPY scripts/ /opt/scripts/

RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
      wget \
      git \
      tigervnc-standalone-server \
      tigervnc-xorg-extension

RUN DEBIAN_FRONTEND=noninteractive apt install -y tasksel dialog
RUN DEBIAN_FRONTEND=noninteractive tasksel install desktop gnome-desktop

RUN \
  && useradd -ms /bin/bash vncuser \
  && mkdir -p /home/vncuser/.vnc/ \
  && mv /opt/scripts/xstartup /home/vncuser/.vnc \
  && chown -R vncuser:vncuser /home/vncuser/.vnc/ \
  && chmod +x /opt/scripts/*

ENTRYPOINT ["/bin/bash", "/opt/scripts/010.vncsetup.sh"]