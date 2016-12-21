#!/bin/bash

/solutions/install_packages.sh

echo Instalando java ...
if [ ! -f /solutions/app/java/bin/java ]; then
	wget -P /solutions/app/ --no-cookies --no-check-certificate --header \
    	"Cookie: oraclelicense=accept-securebackup-cookie" \
    	"http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}-b15/jdk-${JAVA_VERSION}-linux-x64.tar.gz"
	tar -xvzf /solutions/app/jdk-${JAVA_VERSION}-linux-x64.tar.gz -C /solutions/app/
	chmod -R 777 $(ls -d /solutions/app/jdk*/)
	#ln -sf $(ls -d /solutions/app/jdk*/) /solutions/app/java
	mv $(ls -d /solutions/app/jdk*/) /solutions/app/java
fi

echo Instalando ficheros RPM
for rpm_file in ${RPM_PATH}/*.rpm; do
	rpm -Uvh ${rpm_file}
	mv ${rpm_file} ${rpm_file}.ok
done

echo Instalando paquetes oficiales en PIP
for pip_package in $(echo ${PIP_PACKAGES} | sed 's/,/\n/g'); do
	pip3.4 install ${pip_package}
done

echo Instalando paquetes locales en PIP
for pip_zip in ${PIP_PATH}/*.zip; do
	pip3.4 install ${pip_zip}
	mv ${pip_zip} ${pip_zip}.ok
done

echo Ejecutando bash ...
/bin/bash