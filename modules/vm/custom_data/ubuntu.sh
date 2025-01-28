#!/bin/sh

export DEBIAN_FRONTEND=noninteractive

apt update && apt upgrade -y

curl -sL https://aka.ms/InstallAzureCLIDeb | bash
