FROM debian:bullseye
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y php php-fpm php-mysql curl
COPY ./tools/script.sh .
RUN chmod 777 ./script.sh
CMD ["./script.sh"]
