FROM debian:bullseye
RUN apt-get update -y && apt-get install -y nginx openssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=US/ST=State/L=City/O=Organization/CN=localhost"
COPY conf/nginx.conf /etc/nginx/sites-available/default
CMD ["nginx", "-g", "daemon off;"]
