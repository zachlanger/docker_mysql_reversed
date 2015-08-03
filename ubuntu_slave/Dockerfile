FROM ubuntu:14.04
MAINTAINER Zach Langer zlanger@comverge.com

# Install tools and dependencies
RUN apt-get -y update
RUN apt-get install -y ruby
RUN apt-get install -y rails
RUN apt-get install -y openjdk-7-jdk
RUN apt-get install -y openssh-server
RUN apt-get install -y supervisor
RUN apt-get install -y git
RUN apt-get install zlib1g-dev
RUN apt-get install ruby-dev
RUN apt-get install -y libsqlite3-dev
RUN apt-get install -y libmysqlclient-dev
RUN apt-get install -y mysql-server

RUN apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y mysql-client postgresql-client sqlite3 --no-install-recommends && rm -rf /var/lib/apt/lists/*

# Create files where services to run
RUN mkdir -p /usr/src/app /var/run/sshd /var/run/mysqld /var/log/supervisor
WORKDIR /usr/src/app

# Copy config type files
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/

# Install gems
RUN bundle install
RUN gem install listen
RUN gem install guard -v 2.12.9
RUN gem install guard-rspec -v 4.6.3

# REVERSED SECTION
# Create ssh link
COPY generate_ssh.sh /usr/src/app/
RUN bash generate_ssh.sh

# Start mysql and ssh
EXPOSE 22 80
CMD ["/usr/bin/supervisord","-c","/etc/supervisor/conf.d/supervisord.conf"]
