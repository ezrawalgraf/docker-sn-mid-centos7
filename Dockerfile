FROM centos:7

LABEL maintainer="ezra walgraf"

ADD asset/* /opt/

RUN yum update -qy && yum install -qy unzip \
    supervisor \
    vim \
    wget && \
    yum clean packages -qy && \
    rm -rf /tmp/*

RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

RUN sudo yum install -qy xmlstarlet && \
    yum clean packages -qy && \
    rm -rf /tmp/*

RUN wget --no-check-certificate \
      https://install.service-now.com/glide/distribution/builds/package/mid/2019/09/05/mid.newyork-06-26-2019__patch1-hotfix1-09-04-2019_09-05-2019_1536.linux.x86-64.zip \
      -O /tmp/mid.zip && \
    unzip -d /opt /tmp/mid.zip && \
    mv /opt/agent/config.xml /opt/ && \
    chmod 755 /opt/init && \
    chmod 755 /opt/fill-config-parameter && \
    rm -rf /tmp/*

ENTRYPOINT ["/opt/init"]

CMD ["mid:start"]
