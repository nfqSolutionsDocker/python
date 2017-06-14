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
    mysql56 \
    mysql56-devel \
    lapack \
    lapack-devel \
    lapack-static \
    zlib \
    zlib-devel \
    openssl \
    openssl-devel \
    sqlite-devel

# Instalacion sqlite3
#RUN wget -P /usr/src/ "https://www.sqlite.org/2017/sqlite-autoconf-3170000.tar.gz" --no-check-certificate
#RUN tar -xzvf /usr/src/sqlite-autoconf-3170000.tar.gz -C /usr/src/
#RUN /usr/src/sqlite-autoconf-3170000/configure --prefix=/usr/local/sqlite3 --disable-static --enable-fts5 --enable-json1 CFLAGS="-g -O2 -DSQLITE_ENABLE_FTS3=1 -DSQLITE_ENABLE_FTS4=1 -DSQLITE_ENABLE_RTREE=1"

# Instalacion python 3.6.1
RUN wget -P /usr/src/ "https://www.python.org/ftp/python/3.6.1/Python-3.6.1.tgz"
RUN tar -xzf /usr/src/Python-3.6.1.tgz -C /usr/src/
RUN /usr/src/Python-3.6.1/configure
RUN make install -I /usr/src/Python-3.6.1/

# Variables de entorno
ENV RPM_PATH=/solutions/app/rpm \
	PIP_PATH=/solutions/app/pip
	
# Script de arranque
COPY initial.py /solutions/
RUN chmod 777 /solutions/initial.py && \
	chmod a+x /solutions/initial.py

# Volumenes para el python
VOLUME /solutions/app

# Puerto de salida del python
EXPOSE 8888

# Configuracion supervisor
COPY supervisord.conf /etc/supervisord.conf

CMD ["/usr/bin/supervisord"]