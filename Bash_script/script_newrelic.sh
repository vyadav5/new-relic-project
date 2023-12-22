#!/bin/bash

# Prompt the user for input
read -p "Enter New Relic version (e.g., 1.27.4): " V
read -p "Enter system architecture (e.g., amd64): " ARCH
read -p "Enter New Relic license key: " LICENSE_KEY

DOWNLOAD_PATH="$HOME/newrelic-infra_linux_${V}_${ARCH}.tar.gz"
CONFIG_DEFAULTS_FILE="$HOME/newrelic-infra/config_defaults.sh"
INSTALL_FILE="$HOME/newrelic-infra/installer.sh"


# Run the New Relic installation command
V="$V" ARCH="$ARCH"; echo "https://download.newrelic.com/infrastructure_agent/binaries/linux/${ARCH}/newrelic-infra_linux_${V}_${ARCH}.tar.gz" | { read    url; wget "${url}"{,.sum}; shasum -a 256 --check ${url##*/}.sum; }

#unzip tar
echo "Downloading New Relic tar file..."
tar -xzvf "$DOWNLOAD_PATH"

echo "Setting license key in config_defaults.sh..."

#uncomment licence key line and add the user input
sed -i "s|^#license_key=\"\"|license_key=\"$LICENSE_KEY\"|" "$CONFIG_DEFAULTS_FILE"

#run installer.sh to installer new relic
sudo "$INSTALL_FILE"
