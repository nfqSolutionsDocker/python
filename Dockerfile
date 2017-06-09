FROM nfqsolutions/centos:7

MAINTAINER solutions@nfq.com

# Instalacion previa
RUN sudo yum install -y epel-release
RUN sudo yum install -y gcc \
	wget \
	libaio \
    blas_devel \
    lapack-devel \
    fftw \
    fftw-devel \
    atlas-devel \
    atlas \
    atlas-sse3

# Instalacion python 3.6.1
RUN wget -P /usr/src/ "https://www.python.org/ftp/python/3.6.1/Python-3.6.1.tgz"
RUN tar -xzf /usr/src/Python-3.6.1.tgz -C /usr/src/
RUN /usr/src/Python-3.6.1/configure
RUN /usr/src/Python-3.6.1/make altinstall

# Variables de entorno
ENV RPM_PATH=/solutions/app/rpm \
	PIP_PATH=/solutions/app/pip
	
# Script de arranque
COPY python_initial.sh /solutions/
RUN chmod 777 /solutions/python_initial.sh && \
	chmod a+x /solutions/python_initial.sh && \
	sed -i -e 's/\r$//' /solutions/python_initial.sh

# Volumenes para el python
VOLUME /solutions/app

# Puerto de salida del python
EXPOSE 8888

# Configuracion supervisor
COPY supervisord.conf /etc/supervisord.conf

CMD ["/usr/bin/supervisord"]