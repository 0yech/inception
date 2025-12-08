FROM debian:bullseye

RUN apt-get update -y && apt-get install -y \
    proftpd-basic \
    && rm -rf /var/lib/apt/lists/*

COPY conf/proftpd.conf /etc/proftpd/proftpd.conf
COPY tools/setup.sh /setup.sh
RUN chmod +x /setup.sh

EXPOSE 21
EXPOSE 21000-21010

ENTRYPOINT ["/setup.sh"]
