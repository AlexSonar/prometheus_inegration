#!/bin/bash


function has_yum {
  [[ -n "$(command -v yum)" ]]
}

function has_apt_get {
  [[ -n "$(command -v apt-get)" ]]
}

function install_dependencies {
  # log_info "Installing dependencies"

  if $(has_apt_get); then
    # sudo apt-get update -y
    # sudo DEBIAN_FRONTEND=noninteractive apt-get install -y awscli curl unzip jq libcap2-bin
    echo "it is use apt-get"
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