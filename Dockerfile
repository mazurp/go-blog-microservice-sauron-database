# Pull base image.
FROM debian:stretch-slim

RUN apt-get -qqy update \
    && apt-get install -y --no-install-recommends apt-transport-https dirmngr ca-certificates gnupg2 \
    && rm -rf /var/lib/apt/lists/*

RUN apt-key adv --keyserver keys.gnupg.net --recv-keys "539A3A8C6692E6E3F69B3FE81D85E93F801BB43F" \
    && echo "deb https://download.rethinkdb.com/repository/debian-stretch stretch main" > /etc/apt/sources.list.d/rethinkdb.list

ENV RETHINKDB_PACKAGE_VERSION 2.4.1~0stretch

RUN apt-get -qqy update \
	&& apt-get install -y rethinkdb=$RETHINKDB_PACKAGE_VERSION  python-pip \
	&& rm -rf /var/lib/apt/lists/*

# Install python driver for rethinkdb
RUN pip install rethinkdb

#RUN rethinkdb

ADD init_db.py /home/init_db.py

RUN python /home/init_db.py

# Define mountable directories.
VOLUME ["/data"]

# Define working directory.
WORKDIR /data

# Define default command.
CMD ["rethinkdb", "--bind", "all"]

# Expose ports.
#   - 8080: web UI
#   - 28015: process
#   - 29015: cluster
EXPOSE 28015 29015 8080

