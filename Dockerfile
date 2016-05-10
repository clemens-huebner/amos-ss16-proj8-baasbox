FROM appertise/oracle-jdk8
ENV DEBIAN_FRONTEND noninteractive 
RUN apt-get update && \
    apt-get install -y software-properties-common wget unzip && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN wget http://www.baasbox.com/download/baasbox-stable.zip && \
    unzip -o baasbox-stable.zip && \
    mv baasbox*/ /opt/baasbox && \
    mkdir -p /var/data/baasbox && \ 
    chmod +x /opt/baasbox/start
EXPOSE 80
VOLUME /var/data/baasbox
RUN echo #!/usr/bin/env sh >> /opt/baasbox/start
RUN echo    scriptdir=`dirname $0` >> /opt/baasbox/start
RUN echo    classpath="$scriptdir/lib/*" exec java -Dapplication.code=newappcode ${1+"$@"} -cp "$classpath"  play.core.server.NettyServer `dirname $0` >> /opt/baasbox/start
ENTRYPOINT /opt/baasbox/start -Dhttps.port=80 -Dhttp.port=80
