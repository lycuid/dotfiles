# !/bin/bash/
wget -rvO /tmp/code_latest_amd64.deb \
  https://vscode-update.azurewebsites.net/latest/linux-deb-x64/stable
sudo dpkg -i /tmp/code_latest_amd64.deb
rm -rf /tmp/code_latest_amd64.deb
