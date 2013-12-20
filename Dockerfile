FROM stackbrew/ubuntu:saucy
MAINTAINER David Michael <1.david.michael@gmail.com>
RUN echo deb http://dl.hhvm.com/ubuntu saucy main | sudo tee /etc/apt/sources.list.d/hhvm.list
RUN apt-get update
RUN apt-get install -y -q --force-yes apache2 hhvm-fastcgi
ADD http://ftp.drupal.org/files/projects/drupal-7.24.tar.gz /tmp/
ADD 000-default.conf /etc/apache2/sites-available/
RUN cd /tmp ; tar xzvf drupal-7.24.tar.gz
RUN mv /tmp/drupal-7.24/* /var/www/
VOLUME /var/www/site/default/files
RUN chown -R www-data:www-data /var/www/site/default/files
RUN a2enmod proxy_fcgi
RUN service apache2 restart
ENTRYPOINT ["hhvm"]
CMD ["-m", "s", "-vServer.Type=fastcgi", "-vServer.Port=9000", "-vServer.SourceRoot=/var/www"]
