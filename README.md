# Default

The Default template created from `snap init` or `snap init default`

# Using the Image

The Image is available on the docker registry:

```
docker pull snapforbeginners/default
```

The Snap server runs on port 8000, so we'll use that same port on the host:

```
docker run -it -p 8000:8000 snapforbeginners/default
```

# Building

To build a new image, we need to clone this repository and run `docker build`.

```
git clone git@github.com:snapforbeginners/default.git
cd default
docker build -t default .
```

then we can run it as before:

```
docker run -it -p 8000:8000 snapforbeginners/default
```

