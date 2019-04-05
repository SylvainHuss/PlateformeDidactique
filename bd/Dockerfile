FROM mysql

ENV MYSQL_ROOT_PASSWORD mdp

COPY ./files/my.cnf /etc/

COPY ./files/schema.sql /docker-entrypoint-initdb.d/
