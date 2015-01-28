# odoo Postgres

This is a default template, with Postgres added.

# Using the Image

The Image is available on the docker registry along with a pre-set up
Postgres image:

```
docker pull snapforbeginners/odoo-postgres:odoo
docker pull snapforbeginners/odoo-postgres:postgres
```

First, bring up the Postgres container with a name:

```
docker run -it --name odoo-pg snapforbeginners/odoo-postgres:postgres
```

Then use that name (`odoo-pg`) to link the running postgres container
to our application, under the alias "postgres". We'll also expose port
`8000`, since odoo runs on that port.

```
docker run -it --link odoo-pg:postgres -p 8000:8000 snapforbeginners/odoo-postgres:odoo
```

# Building

We can use docker-compose to build and run both containers:

```bash
docker-compose build
docker-compose up -d pg
docker-compose up odoo
```

# Building individually:

To build a new image, we need to clone this repository and run `docker build`.

```
git clone git@github.com:snapforbeginners/odoo-postgres.git
cd odoo-postgres
docker build -t odoo-pg .
```

then we can run it as before:

```
docker run -it -p 8000:8000 odoo-pg
```

