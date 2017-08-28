FROM nfqsolutions/centos:7

MAINTAINER solutions@nfq.com

# Instalacion previa
RUN sudo yum install -y epel-release
RUN sudo yum install -y gcc \
	wget \
	libaio \
    blas_devel \
    fftw \
    fftw-devel \
    atlas-devel \
    atlas \
    atlas-sse3 \
    make \
    mysql \
    mysql-devel \
    lapack \
    lapack-devel \
    lapack-static \
    zlib \
    zlib-devel \
    sqlite-devel

# Instalacion python 3.6
RUN wget -P /usr/src/ "https://www.python.org/ftp/python/3.6.1/Python-3.6.1.tgz" && \
	tar -xzf /usr/src/Python-3.6.1.tgz -C /usr/src/ && \
	/usr/src/Python-3.6.1/configure && \
	make install -I /usr/src/Python-3.6.1/

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


# Configuracion supervisor
COPY supervisord.conf /etc/supervisord.conf

CMD ["/usr/bin/supervisord"]