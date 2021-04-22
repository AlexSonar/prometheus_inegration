#!/usr/bin/env bash

#-------------------------------------------------------------
# Automated solution for integrating continuous monitoring systems Prometheus
# "Ready to go; the example configuration is set up to use Docker-compose
# Comprehensive guide available at: 
# https://alexsonar.github.io/en/continuous-processes/monitoring/prometheus_inegration#top  
#
# By default sudo might not installed on Debian adn return the "-bash: sudo: command not found", but you can install it. 
# First enable su-mode: su -
#
# Copyleft (c) by Alex Sonar 2021
#-------------------------------------------------------------






function has_yum {
  [[ -n "$(command -v yum)" ]]
}

function has_apt_get {
  [[ -n "$(command -v apt-get)" ]]
}

function install_dependencies {
  # log_info "Installing dependencies"

  if $(has_apt_get); then
#     apt-get update
#     apt-get install sudo wget curl nano mc htop vi open-ssh net-tools iputils-ping -y
    # sudo DEBIAN_FRONTEND=noninteractive apt-get install -y awscli curl unzip jq libcap2-bin
      apt update
      apt install apt-file -y
      apt update
      apt install sudo wget curl nano vim mc htop net-tools iputils-ping -y
     #  apt install systemd -y
    echo "it is used apt-get"
    echo "it is used apt-get"
  elif $(has_yum); then
    # sudo yum update -y
    # sudo yum install -y awscli curl unzip jq
    echo "it is use yum"
  else
    log_error "Could not find apt-get or yum. Cannot install dependencies on this OS."
    exit 1
  fi
}

install_dependencies


# apt install sudo wget curl nano mc htop vi open-ssh net-tools iputils-ping -y
cp /etc/prometheus/installers/.bashrc /root
wget -O /etc/prometheus/installers/prometheus.tar.gz https://github.com/prometheus/prometheus/releases/download/v2.26.0/prometheus-2.26.0.linux-amd64.tar.gz
sudo mkdir /etc/prometheus/installers/bin/
sudo mkdir /var/lib/prometheus
[ -d "/usr/lib/systemd" && ! -L "/path/to/dir" ] && echo "Directory /usr/lib/systemd/ exists." || sudo mkdir /usr/lib/systemd/
[ -d "/usr/lib/systemd/system" && ! -L "/path/to/dir" ] && echo "Directory /usr/lib/systemd/system/ exists." || sudo mkdir /usr/lib/systemd/system/
# sudo mkdir /usr/lib/systemd/system/
tar xvfz /etc/prometheus/installers/prometheus*.tar.gz -C /etc/prometheus/installers/bin/
# mv /etc/prometheus/installers/bin/promettheus-* /etc/prometheus/installers/bin/promettheus
for x in /etc/prometheus/installers/bin/*;do mv $x /etc/prometheus/installers/bin/prometheus-files;done
# /etc/prometheus/installers/bin/prometheus-files

# Step Create User

sudo groupadd -f prometheus
sudo useradd -g prometheus --no-create-home --shell /bin/false prometheus
# sudo mkdir /etc/prometheus
# sudo mkdir /var/lib/prometheus
sudo chown prometheus:prometheus /etc/prometheus
sudo chown prometheus:prometheus /var/lib/prometheus

# Step Install Prometheus Libraries
sudo cp -r /etc/prometheus/installers/bin/prometheus-files/consoles /etc/prometheus
sudo cp -r /etc/prometheus/installers/bin/prometheus-files/console_libraries /etc/prometheus
sudo cp /etc/prometheus/installers/bin/prometheus-files/prometheus.yml /etc/prometheus/prometheus.yml

sudo cp /etc/prometheus/installers/bin/prometheus-files/prometheus /usr/local/bin/
sudo cp /etc/prometheus/installers/bin/prometheus-files/promtool /usr/local/bin/

# sudo chown -R prometheus:prometheus /etc/prometheus/consoles
# sudo chown -R prometheus:prometheus /etc/prometheus/console_libraries
# sudo chown prometheus:prometheus /etc/prometheus/prometheus.yml

for i in rules rules.d files_sd; do sudo chown -R prometheus:prometheus /etc/prometheus/${i}; done
for i in rules rules.d files_sd; do sudo chmod -R 775 /etc/prometheus/${i}; done
sudo chown -R prometheus:prometheus /var/lib/prometheus/

# Step 1.6: Setup Service
# sudo vim /usr/lib/systemd/system/prometheus.service

# sudo cp /etc/prometheus/installers/prometheus.service /usr/lib/systemd/system/prometheus.service

sudo tee /etc/systemd/system/prometheus.service<<EOF
[Unit]
Description=Prometheus
Documentation=https://prometheus.io/docs/introduction/overview/
Wants=network-online.target
After=network-online.target

[Service]
Type=simple
User=prometheus
Group=prometheus
ExecReload=/bin/kill -HUP $MAINPID
ExecStart=/usr/local/bin/prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --storage.tsdb.path=/var/lib/prometheus \
  --web.console.templates=/etc/prometheus/consoles \
  --web.console.libraries=/etc/prometheus/console_libraries \
  --web.listen-address=0.0.0.0:9090 \
  --web.external-url=

SyslogIdentifier=prometheus
Restart=always

[Install]
WantedBy=multi-user.target
EOF

sudo chmod 664 /usr/lib/systemd/system/prometheus.service

# Step Reload systemd
# sudo systemctl daemon-reload
# sudo systemctl start prometheus

# sudo systemctl status prometheus

service prometheus start

# sudo systemctl enable prometheus.service

# service /usr/lib/systemd/system/prometheus.service start

# . /usr/local/bin/prometheus --config.file=/etc/prometheus/prometheus.yml
