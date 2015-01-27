FROM postgres:9.4

RUN mkdir -p /docker-entrypoint-initdb.d
ADD ./create_testdb.sh /docker-entrypoint-initdb.d/create_testdb.sh
