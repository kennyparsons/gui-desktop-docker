#FROM debian:buster-slim
FROM jgoerzen/debian-base-minimal

COPY scripts/ /opt/scripts/

RUN apt update \
	&& DEBIAN_FRONTEND=noninteractive apt install -y \
		--no-install-recommends \
		apt-utils \
		apt-file \
	&& DEBIAN_FRONTEND=noninteractive apt install -y \
		wget \
		git \
		runit \
		build-essential \
		libssl-dev \
		x11-xserver-utils \
		dbus-x11 \
		dos2unix \
		python \
		python3 \
		python3-distutils \
		python3-tk \
		python3-dbus \
		tigervnc-standalone-server \
		tigervnc-xorg-extension \
		xauth \
		tasksel \
		dialog \
	&& DEBIAN_FRONTEND=noninteractive tasksel install desktop gnome-desktop \
	&& useradd -ms /bin/bash vncuser \
	&& mkdir -p /home/vncuser/.vnc/ \
	&& mv /opt/scripts/xstartup /home/vncuser/.vnc \
	&& chown -R vncuser:vncuser /home/vncuser/.vnc/ /opt/scripts/* \
	&& chmod 700 /home/vncuser/.vnc/xstartup \
	&& chmod 700 /opt/scripts/*

ENTRYPOINT ["/bin/bash", "/opt/scripts/010.vncsetup.sh"]