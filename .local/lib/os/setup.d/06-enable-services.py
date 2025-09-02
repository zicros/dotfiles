#!/usr/bin/python3
import os
import subprocess
import sys
import tomllib

os_config = {}
with open(os.path.expandvars('/etc/os-release'), 'r') as os_file:
    for line in os_file:
        key, value = line.split('=', 1)
        os_config[key] = value.strip('\n "')

with open(os.path.expandvars(f'$HOME/.config/os/services'), 'rb') as config_file:
    config = tomllib.load(config_file)

os_id = os_config['ID']
if os_id == 'arch':
    system_services = [service_name for service_name,service_config in config[os_id]['system_services'].items() if service_config['enable']]
    user_services = [service_name for service_name,service_config in config[os_id]['user_services'].items() if service_config['enable']]

    if len(system_services) > 0:
        cmd = ' '.join(['sudo', 'systemctl', 'enable'] + system_services)
        subprocess.run(cmd, shell=True)

    if len(user_services) > 0:
        cmd = ' '.join(['systemctl', '--user', 'enable'] + user_services)
        subprocess.run(cmd, shell=True)
else:
    raise f'OS ID is not known: {os_id}'
