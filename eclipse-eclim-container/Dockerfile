FROM ubuntu:latest
MAINTAINER John Pape <jtpape@us.ibm.com>

RUN useradd -ms /bin/bash macsy
RUN apt-get update \
    && apt-get install -y xvfb build-essential cmake make binutils gcc openjdk-8-jdk \
    && apt-get autoremove -y \
    && apt-get clean autoclean \
    && rm -rf /var/lib/{apt,dpkg,cache,log}

ADD http://eclipse.mirror.rafal.ca/technology/epp/downloads/release/neon/2/eclipse-jee-neon-2-linux-gtk-x86_64.tar.gz /home/macsy
ADD https://github.com/ervandew/eclim/releases/download/2.6.0/eclim_2.6.0.jar /home/macsy
ADD entry.sh /entry.sh

RUN chmod -R ugo+rwx /entry.sh

RUN chmod -R ugo+rwx /home/macsy

USER macsy

WORKDIR /home/macsy
RUN tar -zxf /home/macsy/eclipse-jee-neon-2-linux-gtk-x86_64.tar.gz \
    && java -Dvim.files=/home/macsy/.vim -Declipse.home=/home/macsy/eclipse -jar eclim_2.6.0.jar install

RUN rm -fr /home/macsy/eclipse-jee-neon-2-linux-gtk-x86_64.tar.gz \
    && rm -fr /home/macsy/eclim_2.6.0.jar


USER root

ENTRYPOINT ["/entry.sh"]
