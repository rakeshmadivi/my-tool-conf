pxe_booting()
{
  # Requirements
  # 1. DHCP Server; 2. TFTP Server
  # Installing dnsmasq
  # Dnsmasq provides network infrastructure for small networks: DNS, DHCP, router advertisement and network boot
  
  # Set Network Interface with Static IP
  echo Edit /etc/network/interfaces file to have following Network configuration snippet to use Static IP
  echo '
  auto enp0s3
  iface enp0s3 inet static
    address 192.168.1.102
    netmask 255.255.255.0
    network 192.168.1.0
    broadcast 192.168.1.255
    gateway 192.168.1.1
    dns-nameservers 192.168.1.2 8.8.4.4
    dns-search debian.local
    '
  # Now disable and enable the NIC to update the edited changes
  # NIC name: enp0s3
  ifdown enp0s3
  ifup enp0s3
  
  # Check IP is being updated or not
  ip a
  
  # If IP is not enabled with above commands or restarting the networking daemon, restart the system
  init 6 
  # OR
  sudo reboot
  
  # Now install DHCP Server
  # sudo apt-get install isc-dhcp-server
  sudo apt-get install tftpd-hpa syslinux pxelinux nfs-kernel-server
  
  # Using 'dnsmasq'
  # set following configuration in /etc/dnsmasq.conf
  echo '
  interface=eth1
  domain=yourdomain.com
  dhcp-range=192.168.0.3,192.168.0.253,255.255.255.0,1h
  dhcp-boot=pxelinux.0,pxeserver,192.168.0.2
  pxe-service=x86PC, "Install Linux", pxelinux
  enable-tftp
  tftp-root=/srv/tftp
  '
  
}

set_static_ip()
{
  echo TODO
}
