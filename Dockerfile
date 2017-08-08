FROM nfqsolutions/centos:7

MAINTAINER solutions@nfq.com

# Instalacion previa
#RUN sudo yum install -y epel-release
RUN sudo yum install -y \
#    gcc \
#	 wget \
#	 libaio \
#    blas_devel \
#    fftw \
#    fftw-devel \
#    atlas-devel \
#    atlas \
#    atlas-sse3 \
#    make \
#    mysql56 \
#    mysql56-devel \
#    lapack \
#    lapack-devel \
#    lapack-static \
#    zlib \
#    zlib-devel \
#    openssl \
#    openssl-devel \
    sqlite-devel \
    https://centos7.iuscommunity.org/ius-release.rpm

# Instalacion python 3.6.1
RUN sudo yum install -y python36u \
    python36u-pip \
    python36u-devel

# Variables de entorno
ENV RPM_PATH=/solutions/app/rpm \
	PIP_PATH=/solutions/app/pip
	
# Script de arranque
COPY initial.py /solutions/
RUN chmod 777 /solutions/initial.py && \
	chmod a+x /solutions/initial.py && \
	sed -i -e 's/\r$//' /solutions/initial.py

# Volumenes para el python
VOLUME /solutions/app

# Puerto de salida del python
EXPOSE 8888

# Configuracion supervisor
COPY supervisord.conf /etc/supervisord.conf

CMD ["/usr/bin/supervisord"]