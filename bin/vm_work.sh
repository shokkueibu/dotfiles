#!/bin/bash

vmname="windows10workvm"

if ps -A | grep -q $vmname; then
   echo "$vmname is already running." &
   exit 1

else

  OPTS=""
  # Basic CPU settings.
  OPTS="$OPTS -cpu host,kvm=off"
  OPTS="$OPTS -smp 3,sockets=1,cores=3,threads=1"
  # Enable KVM full virtualization support.
  OPTS="$OPTS -enable-kvm"
  # Assign memory to the vm.
  OPTS="$OPTS -m 4G"
  OPTS="$OPTS -mem-path /dev/hugepages"
  OPTS="$OPTS -mem-prealloc"
  # Use the following emulated video device (use none for disabled).
  OPTS="$OPTS -vga none"
  # VFIO GPU and GPU sound passthrough.
  OPTS="$OPTS -device vfio-pci,host=01:00.0,multifunction=on,x-vga=on"  # 1002:6658
  OPTS="$OPTS -device vfio-pci,host=01:00.1"  # 1002:aac0
  # USB passthrough
  OPTS="$OPTS -usb"
  OPTS="$OPTS -usbdevice host:2516:001a"  # Keyboard
  OPTS="$OPTS -usbdevice host:1038:1384"  # Mouse
  # OPTS="$OPTS -usbdevice host:1686:0045"  # Zoom H5
  OPTS="$OPTS -usbdevice host:058f:6364"  # SD Card Reader
  OPTS="$OPTS -usbdevice host:0d8c:000c"  # Sound Card
  # OPTS="$OPTS -usbdevice host:06a3:0762"  # Saitek X52 Pro
  # Supply OVMF (general UEFI bios, needed for EFI boot support with GPT disks).
  #OPTS="$OPTS -drive if=pflash,format=raw,readonly,file=/usr/share/edk2.git/ovmf-x64/OVMF_CODE-pure-efi.fd"
  #OPTS="$OPTS -drive if=pflash,format=raw,file=$(pwd)/OVMF_VARS-pure-efi.fd"
  # Load our created VM image as a harddrive.
  OPTS="$OPTS -drive file=/home/shock/vm/win10-work.qcow2"
  # OPTS="$OPTS -drive file=/dev/sdb,if=virtio"
  # Load our OS setup image e.g. ISO file.
  #OPTS="$OPTS -cdrom $(pwd)/windows_10_professional.iso"
  # Redirect QEMU's console input and output.
  OPTS="$OPTS -monitor stdio"
  # Use a network bridge 
  OPTS="$OPTS -net nic -net bridge,br=br0"
  # Other misc settings
  OPTS="$OPTS -rtc clock=host,base=localtime"
  OPTS="$OPTS -boot c"
  OPTS="$OPTS -serial none -parallel none"
  OPTS="$OPTS -balloon none"

  sudo /usr/local/bin/qemu-system-x86_64 $OPTS
  
  exit 0
fi
