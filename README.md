# multipass-hyperv
testing multipass on hyperv

## Installation procedure
- deploy a vm with ubuntu 22.x

- enable hyperv-tools/daemons :
  - edit /etc/initramfs-tools/modules
  ```sh
  sudo vim /etc/initramfs-tools/modules
  ```
  - add this to the end of file ↓
  ```conf
  ...
  hv_vmbus
  hv_storvsc
  hv_blkvsc
  hv_netvsc
  ```
  ```sh
  sudo apt -y install linux-virtual linux-cloud-tools-virtual linux-tools-virtual
  sudo update-initramfs -u
  sudo reboot
  ```
  - check if ok :
  ```sh
  abdel@multipass-dar:~$ ps aux |grep hv
  root           7  0.0  0.0      0     0 ?        I    23:39   0:00 [kworker/0:0-hv_vmbus_con]
  root         202  0.0  0.0      0     0 ?        I<   23:39   0:00 [hv_vmbus_con]
  root         204  0.0  0.0      0     0 ?        I<   23:39   0:00 [hv_pri_chan]
  root         205  0.0  0.0      0     0 ?        I<   23:39   0:00 [hv_sub_chan]
  root         505  0.0  0.0      0     0 ?        S    23:39   0:00 [hv_balloon]
  root         531  0.0  0.0   3432  2080 ?        Ss   23:39   0:00 /usr/lib/linux-tools/5.15.0-101-generic/hv_kvp_daemon -n
  root         730  0.0  0.0   2780   944 ?        Ss   23:39   0:00 /usr/lib/linux-tools/5.15.0-101-generic/hv_fcopy_daemon -n
  root         731  0.0  0.0   2780   988 ?        Ss   23:39   0:00 /usr/lib/linux-tools/5.15.0-101-generic/hv_vss_daemon -n
  abdel       2936  0.0  0.0   6612  2424 pts/0    S+   23:47   0:00 grep --color=auto hv
  ```

  ```powershell
  PS C:\Users\abdel> get-vm -Name multipass-dar |Get-VMNetworkAdapter

  Name         IsManagementOs VMName        SwitchName MacAddress   Status IPAddresses
  ----         -------------- ------        ---------- ----------   ------ -----------
  Carte réseau False          multipass-dar wsl-extern     00AABBCCDDFF {Ok}   {192.168.1.99, 2a02:a03f:...}
  ```
  - enable nested virtualization
  ```powershell
  Set-VMProcessor -VMName multipass-dar -ExposeVirtualizationExtensions $true
  ```


refs :
- https://community.veeam.com/blogs-and-podcasts-57/how-to-install-hyper-v-integration-services-in-the-ubuntu-linux-vm-6353
- https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/user-guide/enable-nested-virtualization
- https://archive.is/TO9FX
-
