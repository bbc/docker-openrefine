FROM ubuntu:trusty

MAINTAINER jon.tutcher@bbc.co.uk

% set machine proxy variables for inside BBC R&D network
ENV http_proxy=http://www-cache.rd.bbc.co.uk:8080 https_proxy=http://www-cache.rd.bbc.co.uk:8080 HTTP_PROXY=http://www-cache.rd.bbc.co.uk:8080 HTTPS_PROXY=http://www-cache.rd.bbc.co.uk:8080

RUN groupadd -r mysql && useradd -r -g mysql mysql
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | /usr/bin/debconf-set-selections
RUN echo mysql-server mysql-server/root_password password 18473TYG | /usr/bin/debconf-set-selections
RUN echo mysql-server mysql-server/root_password_again password 18473TYG | /usr/bin/debconf-set-selections

RUN apt-get -y -q update; \
    apt-get -y -q install wget make ant g++ software-properties-common

RUN add-apt-repository 'deb http://ppa.launchpad.net/webupd8team/java/ubuntu precise main'; \
    apt-get -y -q update

RUN apt-get install -y --force-yes -q oracle-java7-installer

# a mounted file systems table to make MySQL happy
#RUN cat /proc/mounts > /etc/mtab

# Install gdal dependencies provided by Ubuntu repositories
RUN apt-get install -y -q \
    mysql-server \
    mysql-client \
    python-numpy \
    libpq-dev \
    libpng12-dev \
    libjpeg-dev \
    libgif-dev \
    liblzma-dev \
    libcurl4-gnutls-dev \
    libxml2-dev \
    libexpat-dev \
    libxerces-c-dev \
    libnetcdf-dev \
    netcdf-bin \
    libpoppler-dev \
    gpsbabel \
    swig \
    libhdf4-alt-dev \
    libhdf5-serial-dev \
    libpodofo-dev \
    poppler-utils \
    libfreexl-dev \
    unixodbc-dev \
    libwebp-dev \
    libepsilon-dev \
    liblcms2-2 \
    libpcre3-dev \
    python-dev

% Add and untar Google Refine version 2.5
ADD https://github.com/OpenRefine/OpenRefine/releases/download/2.5/google-refine-2.5-r2407.tar.gz ./
RUN tar -xvf google-refine-2.5-r2407.tar.gz
RUN mv google-refine-2.5/ OpenRefine

% Add and unzip DERI RDF Extension v0.8.0
RUN apt-get install unzip
ADD https://github.com/downloads/fadmaa/grefine-rdf-extension/grefine-rdf-extension-0.8.0.zip /OpenRefine/webapp/extensions/
RUN cd /OpenRefine/webapp/extensions ; \
    unzip grefine-rdf-extension-0.8.0.zip

% start OpenRefine
ADD ./start.sh /start.sh

RUN chmod +x /start.sh

EXPOSE 3333
CMD ["/start.sh"]
