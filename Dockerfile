FROM dockerfile/java:oracle-java8
MAINTAINER Cesare Rocchi <c.rocchi@baasbox.com>
WORKDIR /baasbox

RUN wget --content-disposition http://www.baasbox.com/download/baasbox-stable.zip
RUN unzip baasbox*.zip
RUN rm baasbox*.zip
RUN mv baasbox-*/ baasbox/
RUN chmod +x baasbox/start
RUN --bind all
EXPOSE 80
ENTRYPOINT baasbox/start -Dhttp.port=80
