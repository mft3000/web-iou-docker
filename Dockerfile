FROM debian:8

WORKDIR /

RUN apt-get update -y && \
	apt-get dist-upgrade -y && \
	apt-get dist-upgrade -y && \
	apt-get install -y git

RUN git clone https://github.com/dainok/iou-web && \
	cd iou-web && \
	dpkg -i iou-web_1.2.2-23_all.deb &&  \
	echo 'ServerName myserver.mydomain.com' >> /etc/apache2/apache2.conf
	
RUN apt-get install -y apache2 wget vim && \
	apt-get install php5 \
	php5-pspell \
	libgv-php5 \
	sqlite3 \
	php5-sqlite \
	xdotool \
	php-pear \
	php5-gd \
	php5-cgi 
	
RUN a2dissite 000-default && \
	rm /etc/apache2/sites-available/iou
	
COPY iou.conf /etc/apache2/sites-available/iou.conf

# COPY iourc /opt/iou/bin
# COPY images/* /opt/iou/bin
	
RUN apt-get install -y \
	libpcap0.8 \
	dos2unix \
    lib32z1 \
    lib32ncurses5 \
    lib32bz2-1.0 \
    ibssl1.0.0 \
    libtinfo5 && \
    ln -s /lib/i386-linux-gnu/libcrypto.so.1.0.0 /usr/lib/libcrypto.so.4

EXPOSE 80 

RUN a2enmod cgi && \
	a2ensite iou && \
	service apache2 restart

ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]