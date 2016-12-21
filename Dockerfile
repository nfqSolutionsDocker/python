FROM nfqsolutions/centos:7

MAINTAINER solutions@nfq.com

# Instalacion previa
RUN sudo yum install -y gcc wget python34 python34-pip python34-devel libaio

# Variables de entorno
ENV JAVA_HOME=/solutions/app/java \
	JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF8 \
	JAVA_VERSION=7u80 \
	LD_LIBRARY_PATH=/usr/lib/oracle/11.2/client64/lib \
	ORACLE_HOME=/usr/lib/oracle/11.2/client64 \
	RPM_PATH=/solutions/app/rpm \
	PIP_PATH=/solutions/app/pip
ENV PATH=$PATH:$JAVA_HOME/bin:$ORACLE_HOME/bin

# Script de arranque
COPY python_initial.sh /solutions/
RUN chmod 777 /solutions/python_initial.sh && \
	chmod a+x /solutions/python_initial.sh && \
	sed -i -e 's/\r$//' /solutions/python_initial.sh

# Volumenes para el tomcat
VOLUME /solutions/app

# Puerto de salida del tomcat
EXPOSE 8888

# Configuracion supervisor
COPY supervisord.conf /etc/supervisord.conf

CMD ["/usr/bin/supervisord"]