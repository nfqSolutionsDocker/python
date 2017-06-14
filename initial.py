#!/usr/local/bin/python3

import os

os.system('sh /solutions/install_packages.sh')

RPM_PATH = os.getenv('RPM_PATH')
PIP_PACKAGES = os.getenv('PIP_PACKAGES')
PIP_PATH = os.getenv('PIP_PATH')
PYTHON_FILES = os.getenv('PYTHON_FILES')

for file in os.listdir(RPM_PATH):
    if file.endswith('.rpm'):
        print('Instalando ficheros RPM')
        os.system('rpm -Uvh {}/{}'.format(RPM_PATH,file))

for package in PIP_PACKAGES.split(','):
    print('Instalando paquetes oficiales en PIP')
    os.system('pip3.6 install {}'.format(package))

for file in os.listdir(PIP_PATH):
    if file.endswith('.zip'):
        print('Instalando paquetes locales en PIP .zip')
        os.system('pip3.6 install {}/{}'.format(PIP_PATH,file))

for file in os.listdir(PIP_PATH):
    if file.endswith('.tar.gz'):
        print('Instalando paquetes locales en PIP .tar.gz')
        os.system('pip3.6 install {}/{}'.format(PIP_PATH,file))

for file in PYTHON_FILES.split(','):
    print('Ejecutando ficheros python')
    os.system('python3.6 {} &'.format(file))

print('Ejecutando bash ...')
os.system('/bin/bash')
