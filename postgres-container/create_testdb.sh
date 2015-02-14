gosu postgres postgres --single <<- EOSQL
    CREATE DATABASE testdb;
    GRANT ALL PRIVILEGES ON DATABASE testdb TO postgres;
EOSQL

gosu postgres postgres --single testdb <<- EOSQL
    CREATE TABLE microblogs ( \
        id SERIAL PRIMARY KEY NOT NULL, \
        content TEXT NOT NULL, \
        author TEXT NOT NULL, \
        created_at TIMESTAMP WITH TIME ZONE DEFAULT current_timestamp \
    );
EOSQL
