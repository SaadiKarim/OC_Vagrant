FROM debian:buster-slim
RUN "apt-get update >/etc/null \
    apt-get install -y nginx"
EXPOSE 80