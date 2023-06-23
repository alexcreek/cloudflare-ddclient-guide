FROM ubuntu:20.04
RUN apt-get update \
  && apt-get install -y lsb-release git autoconf make iproute2 \
  perl libdata-validate-ip-perl libio-socket-ssl-perl libjson-pp-perl \
  && apt clean
RUN git clone https://github.com/ddclient/ddclient.git \
  && cd ddclient \
  && git checkout master \
  && sed -i "s/interval('60s')),/interval('300s')),/" ddclient.in \
  && ./autogen \
  && ./configure \
    --prefix=/usr \
    --sysconfdir=/etc/ddclient \
    --localstatedir=/var \
  && make \
  && make VERBOSE=1 check \
  && make install \
  && cd \
  && rm -rf /ddclient
CMD /usr/bin/ddclient -foreground
