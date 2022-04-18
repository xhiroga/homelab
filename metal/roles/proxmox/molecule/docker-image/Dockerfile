FROM geerlingguy/docker-ubuntu2004-ansible

# Building image with add/copy file by molecule is difficult.
# https://stackoverflow.com/questions/52857499/how-to-customize-molecules-docker-image
COPY ./files/usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js
COPY ./files/etc/network/interfaces /etc/network/interfaces
COPY ./files/etc/hosts.test /etc/hosts.test

# debug
RUN apt update && apt install vim -y
