# Base image
FROM debian:buster

# Update packages and install Nginx and OpenSSL
RUN apt-get update -y && apt-get install -y nginx openssl

# Generate self-signed SSL certificate
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=US/ST=State/L=City/O=Organization/CN=localhost"

#Copy Nginx configuration file
COPY conf/nginx.conf /etc/nginx/

# Expose port 80 for HTTP traffic and port 443 for HTTPS traffic
# EXPOSE  443

# Start Nginx when the container starts
CMD ["nginx", "-g", "daemon off;"]
# CMD [ "bash" ]
