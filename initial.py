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
        os.system('rpm -Uvh {}'.format(file))

#ls -l ${RPM_PATH}/*.rpm > /dev/null 2>&1
#if [ "$?" = "0" ]; then
#print('Instalando ficheros RPM')
#for rpm_file in ${RPM_PATH}/*.rpm; do
#    rpm -Uvh ${rpm_file}
#done
#fi

for file in os.listdir(PIP_PACKAGES):
    print('Instalando paquetes oficiales en PIP')
    os.system('pip3.6 install {}'.format(file))

#print ('Instalando paquetes oficiales en PIP')
#for pip_package in $(echo ${PIP_PACKAGES} | sed 's/,/\n/g'); do
#    pip3.4 install ${pip_package}
#done

for file in os.listdir(PIP_PATH):
    if file.endswith('.zip'):
        print('Instalando paquetes locales en PIP .zip')
        os.system('pip3.6 install {}'.format(file))

#ls -l ${PIP_PATH}/*.zip > /dev/null 2>&1
#if [ "$?" = "0" ]; then
#print('Instalando paquetes locales en PIP .zip')
#for pip_zip in ${PIP_PATH}/*.zip; do
#    pip3.4 install ${pip_zip}
#done
#fi

for file in os.listdir(PIP_PATH):
    if file.endswith('.tar.gz'):
        print('Instalando paquetes locales en PIP .tar.gz')
        os.system('pip3.6 install {}'.format(file))

#ls -l ${PIP_PATH}/*.tar.gz > /dev/null 2>&1
#if [ "$?" = "0" ]; then
#print('Instalando paquetes locales en PIP .tar.gz')
#for pip_targz in ${PIP_PATH}/*.tar.gz; do
#    pip3.4 install ${pip_targz}
#done
#fi

for file in os.listdir(PYTHON_FILES):
    print('Ejecutando ficheros python')
    os.system('python3.6 {} &'.format(file))

#print('Ejecutando ficheros python')
#for python_file in $(echo ${PYTHON_FILES} | sed 's/,/\n/g'); do
#    python3 ${python_file} &
#done

print('Ejecutando bash ...')
os.system('/bin/bash')
#/bin/bash
