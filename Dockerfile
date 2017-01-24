FROM centos:6
MAINTAINER jasonlin

USER root

RUN yum update -y && yum groupinstall -y "Development Tools" && yum install -y gnupg subversion && \
    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 && \
    curl -sSL https://get.rvm.io | bash -s stable --ruby=1.9.3 && rm -f /bin/sh && ln -s /bin/bash /bin/sh && \
    echo "source /usr/local/rvm/scripts/rvm" >> /etc/profile && bash -l -c "rvm use 1.9.3 && gem install puppet -v=3.2.4 && gem update facter"

WORKDIR /etc/puppet
COPY ./ssl /etc/puppet/ssl

EXPOSE 8140

ENTRYPOINT ["/bin/bash"]
