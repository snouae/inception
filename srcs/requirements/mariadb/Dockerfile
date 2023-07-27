FROM debian:buster

RUN apt-get update && apt-get install -y mariadb-server

COPY ./tools/script.sh .

RUN chmod +x ./script.sh


# COPY  ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

#EXPOSE 3306

CMD ["./script.sh"]

# ENTRYPOINT [ "./script.sh" ]

# CMD ["mysqld_safe"]
