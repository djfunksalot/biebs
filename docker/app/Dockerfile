FROM ubuntu:bionic
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
&& apt-get install -y --no-install-recommends \
apt-utils \
ed \
less \
locales \
vim-tiny \
wget \
ca-certificates \
apt-transport-https \
gsfonts \
gnupg \
libcurl4-openssl-dev \
xz-utils \
libssl-dev \
libsasl2-dev \
libxml2-dev

# Configure default locale, see https://github.com/rocker-org/rocker/issues/19
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
	&& locale-gen en_US.utf8 \
	&& /usr/sbin/update-locale LANG=en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
#install R
RUN echo "deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran40/" > /etc/apt/sources.list.d/cran.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 51716619E084DAB9
ENV R_BASE_VERSION 4.0.2
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		r-base=${R_BASE_VERSION}* \
		r-base-dev=${R_BASE_VERSION}* \
		r-recommended=${R_BASE_VERSION}* \
        && echo 'options(repos = c(CRAN = "https://cloud.r-project.org/"), download.file.method = "libcurl")' >> /etc/R/Rprofile.site 
#	&& rm -rf /var/lib/apt/lists/* \
#        && echo 'source("/etc/R/Rprofile.site")' >> /etc/littler.r
RUN useradd biebs -u 1000\
        && mkdir /home/biebs \
        && chown biebs:biebs /home/biebs \
        && addgroup biebs staff
RUN R -e "install.packages(c('cognitoR','data.table','dplyr','DT','ggplot2','knitr','meta','metafor','metasens','mongolite','mongolite','netmeta','rmarkdown','shiny','shinyBS','shinydashboard','shinyjs','shinyLP','xmeta'), repos='https://cloud.r-project.org/')"

#install nodejs and pm2
RUN wget --quiet https://nodejs.org/dist/v14.8.0/node-v14.8.0-linux-x64.tar.xz -O ~/node.tar.xz && \
    tar -xvf ~/node.tar.xz -C /opt/ && \
    rm ~/node.tar.xz
ENV PATH /opt/node-v14.8.0-linux-x64/bin:$PATH
RUN npm install -g pm2 --silent --progress=false

COPY Rprofile.site /usr/lib/R/etc/
CMD ["pm2-runtime","/shiny/ecosystem.config.js"]
