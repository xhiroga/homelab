PVE_VERSION = 7.0-2
UBUNTU_VERSION = 20.04.4

proxmox-ve_$(PVE_VERSION).iso:
	wget http://download.proxmox.com/iso/$@ -O $@

ubuntu-$(UBUNTU_VERSION)-desktop-amd64.iso:
	wget https://releases.ubuntu.com/$(UBUNTU_VERSION)/$@ -O $@

ubuntu-$(UBUNTU_VERSION)-live-server-amd64.iso:
	wget https://releases.ubuntu.com/$(UBUNTU_VERSION)/$@ -O $@

virtio-win.iso:
	wget https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/$@ -O $@
