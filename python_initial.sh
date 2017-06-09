#!/bin/bash

/solutions/install_packages.sh

ls -l ${RPM_PATH}/*.rpm > /dev/null 2>&1
if [ "$?" = "0" ]; then
echo Instalando ficheros RPM
for rpm_file in ${RPM_PATH}/*.rpm; do
	rpm -Uvh ${rpm_file}
done
fi

echo Instalando paquetes oficiales en PIP
for pip_package in $(echo ${PIP_PACKAGES} | sed 's/,/\n/g'); do
	pip3.4 install ${pip_package}
done

ls -l ${PIP_PATH}/*.zip > /dev/null 2>&1
if [ "$?" = "0" ]; then
echo Instalando paquetes locales en PIP .zip
for pip_zip in ${PIP_PATH}/*.zip; do
	pip3.4 install ${pip_zip}
done
fi

ls -l ${PIP_PATH}/*.tar.gz > /dev/null 2>&1
if [ "$?" = "0" ]; then
echo Instalando paquetes locales en PIP .tar.gz
for pip_targz in ${PIP_PATH}/*.tar.gz; do
	pip3.4 install ${pip_targz}
done
fi

echo Ejecutando ficheros python
for python_file in $(echo ${PYTHON_FILES} | sed 's/,/\n/g'); do
	python3 ${python_file} &
done

echo Ejecutando bash ...
/bin/bash
