FROM centos:7

LABEL maintainer="ezra walgraf"

ADD asset/* /opt/

RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

RUN yum update -y && yum install -y unzip \
    supervisor \
    vim \
    sysvinit-tools \
    xmlstarlet \
    wget && \
    yum clean packages -y && \
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
