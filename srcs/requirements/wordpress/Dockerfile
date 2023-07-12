FROM debian:buster

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y php php-fpm php-mysql curl
# RUN wget https://wordpress.org/latest.tar.gz -P /var/www
# RUN tar -xzf /var/www/latest.tar.gz -C /var/7www/
# RUN chown -R root:root /var/ww

# COPY tools/script.sh /

# RUN chmod 777 /script.sh


COPY ./tools/script.sh .

RUN chmod 777 ./script.sh
# WORKDIR /var/www/wordpress

# ENTRYPOINT [ "./script.sh" ]

CMD ["sh", "script.sh"]
