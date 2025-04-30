#!/usr/bin/bash
cat /etc/locale.gen | sed 's/^#\s*\(en_US.UTF-8\)/\1/' | sudo tee /tmp/locale.gen > /dev/null
sudo mv /tmp/locale.gen /etc/locale.gen
sudo locale-gen
