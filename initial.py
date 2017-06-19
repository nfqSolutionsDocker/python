#!/usr/local/bin/python3

import os

os.system('sh /solutions/install_packages.sh')

RPM_PATH = os.getenv('RPM_PATH')
PIP_PACKAGES = os.getenv('PIP_PACKAGES')
PIP_PATH = os.getenv('PIP_PATH')
PYTHON_FILES = os.getenv('PYTHON_FILES')
SERVICES = os.getenv('SERVICES')

for file in os.listdir(RPM_PATH):
    if file.endswith('.rpm'):
        print('Instalando ficheros RPM: {}'.format(file))
        os.system('rpm -Uvh {}/{}'.format(RPM_PATH,file))

for package in PIP_PACKAGES.split(','):
    print('Instalando paquetes oficiales en PIP: {}'.format(package))
    os.system('pip3.6 install {}'.format(package))

for file in os.listdir(PIP_PATH):
    if file.endswith('.zip'):
        print('Instalando paquetes locales en PIP .zip: {}'.format(file))
        os.system('pip3.6 install {}/{}'.format(PIP_PATH,file))

for file in os.listdir(PIP_PATH):
    if file.endswith('.tar.gz'):
        print('Instalando paquetes locales en PIP .tar.gz: {}'.format(file))
        os.system('pip3.6 install {}/{}'.format(PIP_PATH,file))

for file in PYTHON_FILES.split(','):
    print('Ejecutando ficheros python: {}'.format(file))
    os.system('python3.6 {} &'.format(file))

for file in SERVICES.split(','):
    print('Ejecutando service: {}'.format(file))
    os.system('{} &'.format(file))

print('Ejecutando bash ...')
os.system('/bin/bash')
