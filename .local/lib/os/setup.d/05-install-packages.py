#!/usr/bin/python3
import os
import subprocess
import sys
import tomllib
import shutil

def command_exists(cmd):
    return shutil.which(cmd) is not None

os_config = {}
with open(os.path.expandvars('/etc/os-release'), 'r') as os_file:
    for line in os_file:
        key, value = line.split('=', 1)
        os_config[key] = value.strip('\n "')

with open(os.path.expandvars(f'$HOME/.config/os/packages'), 'rb') as config_file:
    config = tomllib.load(config_file)

os_id = os_config['ID']
if os_id == 'arch':
    if command_exists('pacman'):
        cmd = ' '.join(['sudo', 'pacman', '--noconfirm', '-S'] + config[os_id]['packages'])
        subprocess.run(cmd, shell=True)

    if command_exists('yay') and ('aur_packages' in config[os_id]) and (len(config[os_id]['aur_packages']) > 0):
        cmd = ' '.join(['yay', '--noconfirm', '-S'] + config[os_id]['aur_packages'])
        print(f'Using YAY:{cmd}')
        subprocess.run(cmd, shell=True)

elif os_id == 'ubuntu':
    print("Debian based install")
    cmd = ' '.join(['sudo', 'apt-get', 'install', '-y'] + config[os_id]['packages'])
    subprocess.run(cmd, shell=True)
else:
    raise f'OS ID is not known: {os_id}'
