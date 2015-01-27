gosu postgres postgres --single <<- EOSQL
    CREATE DATABASE testdb;
    GRANT ALL PRIVILEGES ON DATABASE testdb TO postgres;
EOSQL
