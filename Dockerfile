# use latest stable debian
FROM debian:stable
# install nginx and openssh
RUN apt-get update && apt-get install -y nginx openssh-server
# create a group and user for ssh connection
RUN groupadd sshgroup && useradd -ms /bin/bash -g sshgroup sshuser
# add users password
RUN echo 'sshuser:password' | chpasswd
# expose ports (maping inside VAarantfile)
EXPOSE 8080 1022
# start ssh and nginx on container launch
CMD service ssh start && nginx -g 'daemon off;'