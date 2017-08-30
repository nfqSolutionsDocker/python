#!/usr/local/bin/python3

import os
import time

os.system('sh /solutions/install_packages.sh')

RPM_PATH = os.getenv('RPM_PATH')
PIP_PACKAGES = os.getenv('PIP_PACKAGES')
PIP_PATH = os.getenv('PIP_PATH')
PYTHON_FILES = os.getenv('PYTHON_FILES')
SERVICES = os.getenv('SERVICES')

# FALSE if RPM_PATH is '' or None
if bool(RPM_PATH):
    rpm_file_list = os.listdir(RPM_PATH)
    rpm_file_list.sort()
    for file in rpm_file_list:
        if file.endswith('.rpm'):
            print('\033[1;32mInstalando ficheros RPM: {}\033[0m'.format(file))
            os.system('rpm -Uvh {}/{}'.format(RPM_PATH,file))

# FALSE if PIP_PACKAGES is '' or None
if bool(PIP_PACKAGES):
    for package in PIP_PACKAGES.split(','):
        print('\033[1;32mInstalando paquetes oficiales en PIP: {}\033[0m'.format(package))
        os.system('pip3.6 install {}'.format(package))

# FALSE if PIP_PATH is '' or None
if bool(PIP_PATH):
    pip_file_list = os.listdir(PIP_PATH)
    pip_file_list.sort()
    for file in pip_file_list:
        if file.endswith('.zip'):
            print('\033[1;32mInstalando paquetes locales en PIP .zip: {}\033[0m'.format(file))
            os.system('pip3.6 install {}/{}'.format(PIP_PATH, file))

        if file.endswith('.tar.gz'):
            print('\033[1;32mInstalando paquetes locales en PIP .tar.gz: {}\033[0m'.format(file))
            os.system('pip3.6 install {}/{}'.format(PIP_PATH, file))

# FALSE if PYTHON_FILES is '' or None
if bool(PYTHON_FILES):
    for file in PYTHON_FILES.split(','):
        print('\033[1;32mEjecutando ficheros python: {}\033[0m'.format(file))
        os.system('python3.6 {} &'.format(file))

# FALSE if SERVICES is '' or None
if bool(SERVICES):
    for file in SERVICES.split(','):
        print('\033[1;32mEjecutando service: {}\033[0m'.format(file))
        os.system('{} &'.format(file))
        time.sleep(5)

print('\033[1;32mEjecutando bash ...\033[0m')
os.system('/bin/bash')
