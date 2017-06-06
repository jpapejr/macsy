FROM ubuntu:latest
MAINTAINER John Pape <jpapejr@icloud.com>

RUN useradd -s /bin/bash -m macsy

RUN apt-get update && apt-get install -y bash git curl xvfb openjdk-8-jdk software-properties-common \
    && apt-add-repository -y ppa:adrozdoff/emacs && apt-get update \
    && apt-get install -y emacs25 \
    
    

ADD https://raw.githubusercontent.com/isaacs/nave/master/nave.sh /home/macsy/nave.sh
ADD emacs /home/macsy/.emacs
ADD tern-project /home/macsy/.tern-project
ADD entry.sh /entry.sh
RUN chmod +x /entry.sh && chmod +x /home/macsy/nave.sh && ln -s /home/macsy/nave.sh /usr/local/bin/nave \
    && nave usemain 6.9.5

VOLUME /data
    
RUN npm install -g tern eslint babel-eslint eslint-plugin-import eslint-config-airbnb-base


RUN chmod +rwx /home/macsy/.emacs \
    && chmod +rwx /home/macsy/.tern-project \
    && chown -R macsy:macsy /home/macsy

USER macsy

RUN echo "osgi.instance.area.default=/projects/java" >> /home/macsy/.eclimrc

WORKDIR /projects

ENTRYPOINT ["/entry.sh"]