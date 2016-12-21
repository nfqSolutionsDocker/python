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
for f in $(ls $RPM_PATH/*.rpm | sort -r); do
	rpm -Uvh $f
	mv $f $f.ok
done

echo Instalando paquetes en PIP
for pip_package in $(echo ${PIP_PACKAGES} | sed 's/,/\n/g'); do
	pip3.4 install ${pip_package}
done

echo Ejecutando bash ...
/bin/bash