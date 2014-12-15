FROM haskell:7.8

# update packages
RUN apt-get update
RUN apt-get install -y git
RUN cabal update

# Install Dependencies into sandbox. Each command is cached by Docker
# so we don't have to reinstall everything unless we make changes to 
# our .cabal file.
ADD ./odoo.cabal /opt/odoo/odoo.cabal

### 1.0 dependencies
RUN git clone https://github.com/snapframework/io-streams-haproxy.git /opt/deps/io-streams-haproxy
RUN git clone https://github.com/snapframework/snap.git /opt/deps/snap
RUN git clone https://github.com/snapframework/snap-core.git /opt/deps/snap-core
RUN git clone https://github.com/snapframework/snap-server.git /opt/deps/snap-server
RUN git clone https://github.com/snapframework/snap-loader-static.git /opt/deps/snap-loader-static
RUN git clone https://github.com/snapframework/heist.git /opt/deps/heist

# Create Sandbox and Add Source Deps
RUN cd /opt/odoo &&\
        cabal sandbox init &&\
        cabal sandbox add-source /opt/deps/io-streams-haproxy &&\
        cabal sandbox add-source /opt/deps/snap &&\
        cabal sandbox add-source /opt/deps/snap-core &&\
        cabal sandbox add-source /opt/deps/snap-server &&\
        cabal sandbox add-source /opt/deps/snap-loader-static &&\
        cabal sandbox add-source /opt/deps/heist

### END 1.0 dependencies

RUN cd /opt/odoo && cabal install --only-dependencies -j4

# Add Application Code
ADD ./src /opt/odoo/src
# Install Application
RUN cd /opt/odoo && cabal build

# Add production assets and run application

ADD ./log /opt/odoo/log
ADD ./snaplets /opt/odoo/snaplets
ADD ./static /opt/odoo/static
ADD ./.ghci /opt/odoo/.ghci

WORKDIR /opt/odoo

CMD ["/opt/odoo/dist/build/odoo/odoo"]
