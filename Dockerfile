FROM stackbrew/ubuntu:saucy
MAINTAINER David Michael <1.david.michael@gmail.com>
RUN echo deb http://dl.hhvm.com/ubuntu saucy main | sudo tee /etc/apt/sources.list.d/hhvm.list
RUN apt-get update
RUN apt-get install -y -q --force-yes apache2 hhvm-fastcgi
ADD http://ftp.drupal.org/files/projects/drupal-7.24.tar.gz /var/www/
RUN cd /var/www ; tar xzvf drupal-7.24.tar.gz ; mv drupal-7.24.tar.gz drupal
EXPOSE 80
ENTRYPOINT apachectl -D FOREGROUND 
