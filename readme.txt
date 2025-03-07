# --- *** poste mail server with Docker in Linux Mint 21. *** --- #

--- official web site address ---
https://poste.io/doc/getting-started

--- github repo ---
--- youtube ---
https://youtu.be/u4PLm3lPx9M

Develop Enviroment:
---
Linux Mint 21.2 Mate x64.
Docker version 24.0.7, build 24.0.7-0ubuntu2~22.04.1
git version 2.34.1
Github Desktop version 3.2.0-linux1 (x64)
Visual Studio Code version 1.96.4
---

1 --- download image poste from hub docker ---
$ sudo docker pull analogic/poste.io
$ sudo docker images |grep poste.io

$ mkdir -p /opt/linux/poste/data
$ cd /opt/linux/poste
$ ls -l
---
drwxr-xr-x 11 mail mail 4096 Mar  6 15:54 data
-rwxr-xr-x  1 root root   58 Mar  6 15:48 poste-down.sh
-rwxr-xr-x  1 root root  172 Mar  6 15:44 poste-up.sh
---

$ sudo chmod 777 -Rvf ../poste
$ sudo chown nobody:nogroup -Rvf ../poste

2 --- Test the container --- #
---
sudo docker run \
    --net=host \
    -e TZ=Havana/Cuba \
    -v $(pwd)/data:/data \
    --name "mailserver" \
    -h "mail.example.com" \
    -t analogic/poste.io
---

3 --- Create the poste-up file --- #
$ sudo touch poste-up.sh
$ sudo cat poste-up.sh
---
#!/bin/bash
docker run \
    --net=host \
    -e TZ=Havana/Cuba \
    -v $(pwd)/data:/data \
    --name "mailserver" \
    -h "mail.example.com" \
    -t analogic/poste.io
---

# --- Create the poste-down file --- #
$ sudo touch poste-down.sh
$ sudo cat poste-down.sh
---
#!/bin/bash
docker stop mailserver
#
docker rm mailserver
---

$ sudo chmod +x *.sh

# Auto Start Containers after System Reboot.

$ cd ~
$ sudo nano /etc/systemd/system/docker-poste.service
---
[Unit]
Description=poste
Requires=docker.service
After=docker.service

[Service]
Restart=always
ExecStart=/usr/bin/bash /opt/linux/poste/poste-up.sh
ExecStop=/usr/bin/bash /opt/linux/poste/poste-down.sh

[Install]
WantedBy=default.target
---

sudo systemctl enable docker-poste.service // for enable.
sudo systemctl disable docker-poste.service //disable if you want.

# --- *** poste mail server in Linux Mint 21. *** --- #

VNSGNc23Dk

