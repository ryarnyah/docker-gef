FROM debian:jessie

MAINTAINER Ryar Nyah <ryarnyah@gmail.com>

VOLUME ["/src"]

WORKDIR ["/src", "/tmp/gef"]

# Install GEF
RUN dpkg --add-architecture i386 && \
  apt-get update && \
  apt-get install python-pip gdb gdbserver gdb-multiarch git make gcc g++ wget cmake pkg-config libc6:i386 libstdc++6:i386 libglib2.0-dev binutils -y && \
  cd /src && git clone https://github.com/unicorn-engine/unicorn.git && cd unicorn/bindings/python/ && make install && \
  cd /src && git clone https://github.com/keystone-engine/keystone.git && cd keystone/bindings/python && make install && \
  pip install ropgadget ropper capstone keystone-engine && \
  wget -q -O ~/.gdbinit-gef.py https://github.com/hugsy/gef/raw/master/gef.py && \
  echo source ~/.gdbinit-gef.py >> ~/.gdbinit && \
  apt-get remove -y --purge git make gcc g++ wget cmake pkg-config && apt-get autoremove -y --purge && apt-get -y autoclean
