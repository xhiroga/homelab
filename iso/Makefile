ANDROID_X86_VERSION = 8.1-r6
PVE_VERSION = 7.1-2
UBUNTU_VERSION = 20.04.4

proxmox-ve_$(PVE_VERSION).iso:
	wget http://download.proxmox.com/iso/$@ -O $@

ubuntu-$(UBUNTU_VERSION)-desktop-amd64.iso:
	wget https://releases.ubuntu.com/$(UBUNTU_VERSION)/$@ -O $@

ubuntu-$(UBUNTU_VERSION)-live-server-amd64.iso:
	wget https://releases.ubuntu.com/$(UBUNTU_VERSION)/$@ -O $@

virtio-win.iso:
	wget https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/$@ -O $@

android-x86_64-$(ANDROID_X86_VERSION).iso:
	wget https://ftp.halifax.rwth-aachen.de/osdn/android-x86/69704/$@ -O $@

chromeos_14516.0.0_reven_recovery_dev-channel_mp-v2.bin.zip:
	wget https://dl.google.com/dl/edgedl/chromeos/recovery/$@ -O $@

chromeos_14516.0.0_reven_recovery_dev-channel_mp-v2.bin: chromeos_14516.0.0_reven_recovery_dev-channel_mp-v2.bin.zip;
	unzip chromeos_14516.0.0_reven_recovery_dev-channel_mp-v2.bin.zip
