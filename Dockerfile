FROM wordpress:latest
MAINTAINER David Roth

ENV DEBIAN_FRONTEND noninteractive

RUN apt update && apt install wget ssl-cert sendmail -y

#add mod-pagespeed
RUN \
    wget -q https://dl-ssl.google.com/dl/linux/direct/mod-pagespeed-stable_current_amd64.deb && \
    dpkg -i mod-pagespeed-*.deb && \
    apt-get -f install -y && \
    rm mod-pagespeed-*.deb

#set sendmail
RUN { \
    echo "sendmail_path = /usr/sbin/sendmail -t -i"; \
  } > /usr/local/etc/php/conf.d/mail.ini

RUN update-rc.d sendmail defaults

RUN apt remove --purge -y wget && \
    apt-get autoremove -y && \
    apt-get clean

EXPOSE 80 443
