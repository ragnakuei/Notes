# Ubuntu 20.04 安裝 Guest Tools

在虛擬機 Ubuntu 上執行：

- 安裝這個[套件](https://www.nakivo.com/blog/wp-content/uploads/2021/06/install.7z)
- wget wget https://raw.githubusercontent.com/Hinara/linux-vm-tools/ubuntu20-04/ubuntu/20.04/install.sh 
- sudo sh install.sh

到本機上執行：

- Set-VM -VMName <虛擬機名稱> -EnhancedSessionTransportType HvSocket
  - Set-VM -VMName 'Ubuntu 20.04' -EnhancedSessionTransportType HvSocket