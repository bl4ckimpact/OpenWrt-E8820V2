#!/bin/bash

# 1. Tambahkan interface WAN USB ke /etc/config/network
sed -i '$a \\nconfig interface "wan_usb"\n\toption proto "dhcp"\n\toption device "usb0"\n\toption peerdns "1"' package/base-files/files/etc/config/network

# 2. Masukkan wan_usb ke Zona WAN di firewall agar NAT aktif
# Mencari baris 'list network wan' dan menambahkan 'list network wan_usb' di bawahnya
sed -i '/list network .wan./a \	list network "wan_usb"' package/network/config/firewall/files/firewall.config

# 3. Opsional: Mengubah IP LAN agar tidak bentrok dengan IP Tethering HP (biasanya 192.168.42.x)
# Kita set IP Router ke 192.168.10.1
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate
