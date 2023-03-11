FROM geerlingguy/docker-ubuntu2004-ansible

RUN ln -s /usr/bin/true /usr/sbin/pvesm

# Update before copy because files includes Proxmox enterprise repository
RUN apt update && apt install vim -y

# Building image with add/copy file by molecule is difficult.
# https://stackoverflow.com/questions/52857499/how-to-customize-molecules-docker-image
COPY ./files/ /
