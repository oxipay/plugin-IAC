FROM wordpress:latest

ENV XDEBUG_PORT 9000

RUN yes | pecl install xdebug && \
    echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini && \
	echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini && \
	echo "xdebug.idekey=phpstorm" >> /usr/local/etc/php/conf.d/xdebug.ini && \
	echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini && \
	echo "dns-nameservers 10.130.8.11 10.130.8.12" >> /etc/network/interfaces
EXPOSE 9000
	
