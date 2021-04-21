
# By default sudo might not installed on Debian adn return the "-bash: sudo: command not found", but you can install it. 
# First enable su-mode: su -



function has_yum {
  [[ -n "$(command -v yum)" ]]
}

function has_apt_get {
  [[ -n "$(command -v apt-get)" ]]
}

function install_dependencies {
  # log_info "Installing dependencies"

  if $(has_apt_get); then
    apt-get update
    apt-get install sudo wget curl nano mc htop vi open-ssh net-tools iputils-ping -y
    # sudo DEBIAN_FRONTEND=noninteractive apt-get install -y awscli curl unzip jq libcap2-bin
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

cp /etc/prometheus/installers/.bashrc /root
wget -O /etc/prometheus/installers/prometheus.tar.gz https://github.com/prometheus/prometheus/releases/download/v2.26.0/prometheus-2.26.0.linux-amd64.tar.gz
mkdir /etc/prometheus/installers/bin/
tar xvfz /etc/prometheus/installers/prometheus*.tar.gz -C /etc/prometheus/installers/bin/
mv /etc/prometheus/installers/bin/promettheus-* promettheus