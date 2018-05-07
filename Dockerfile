FROM i386/debian:8

WORKDIR /

RUN apt-get update -y && \
	apt-get dist-upgrade -y && \
	apt-get dist-upgrade -y && \
	apt-get install -y git

RUN apt-get install -y apache2 wget vim && \
	apt-get install -y php5 \
	php5-pspell \
	libgv-php5 \
	sqlite3 \
	php5-sqlite \
	xdotool \
	php-pear \
	php5-gd \
	php5-cgi \
	libpcap0.8 \
	dos2unix \
    ibssl1.0.0 \
    libtinfo5 

# RUN apt-get install -y php5 \
    # lib32z1 \
    # lib32ncurses5 \
    # ln -s /lib/i386-linux-gnu/libcrypto.so.1.0.0 /usr/lib/libcrypto.so.4

RUN git clone https://github.com/dainok/iou-web && \
	cd iou-web && \
	dpkg -i iou-web_1.2.2-23_all.deb &&  \
	echo 'ServerName myserver.mydomain.com' >> /etc/apache2/apache2.conf

RUN a2dissite 000-default 

RUN	rm /etc/apache2/sites-available/iou && \
	rm /etc/apache2/sites-enabled/001-iou
	
COPY iou.conf /etc/apache2/sites-available/iou.conf

# COPY iourc /opt/iou/bin
# COPY images/* /opt/iou/bin
COPY iou-web-export-20180507140350.gz /opt/iou/

RUN a2enmod cgi && \
	a2ensite iou && \
	service apache2 restart
	
EXPOSE 80 

ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]