FROM ubuntu:latest
MAINTAINER John Pape <jpapejr@icloud.com

RUN useradd -ms /bin/bash macsy


RUN apt-get update \
    && apt-get install --no-install-recommends -y \
    xvfb \
    apt-transport-https ca-certificates curl \
    software-properties-common openjdk-8-jdk libdigest-sha-perl \
    ngrok-client xvfb \
    && apt-get autoremove -y \
    && apt-get clean autoclean \
    && rm -rf /var/lib/{apt,dpkg,cache,log} 

RUN Xvfb :1 -screen 0 1024x768x24 &

RUN curl https://raw.githubusercontent.com/isaacs/nave/master/nave.sh > $HOME/nave.sh \
    && chmod +x $HOME/nave.sh && ln -s $HOME/nave.sh /usr/local/bin/nave \
    && nave usemain 6.9.5

RUN npm install -g tern eslint babel-eslint eslint-plugin-import eslint-config-airbnb-base

RUN apt-add-repository -y ppa:adrozdoff/emacs \
    && apt update \
    && apt install -y emacs25
    
ADD http://eclipse.mirror.rafal.ca/technology/epp/downloads/release/neon/2/eclipse-jee-neon-2-linux-gtk-x86_64.tar.gz /home/macsy/eclipse-jee-neon-2-linux-gtk-x86_64.tar.gz
ADD https://github.com/ervandew/eclim/releases/download/2.6.0/eclim_2.6.0.jar /home/macsy/eclim_2.6.0.jar
ADD entry.sh /entry.sh

RUN chmod o+rwx /home/macsy/eclipse-jee-neon-2-linux-gtk-x86_64.tar.gz \
    && chmod o+rwx /home/macsy/eclim_2.6.0.jar \
    && chmod +x /entry.sh
    
        
USER macsy
WORKDIR /home/macsy


RUN tar -zxf $HOME/eclipse-jee-neon-2-linux-gtk-x86_64.tar.gz \
    && echo "osgi.instance.area.default=@user.home/projects/java" >> $HOME/.eclimrc
    

RUN java -Dvim.files=/$HOME/.vim -Declipse.home=$HOME/eclipse -jar eclim_2.6.0.jar install

ADD tern-project /home/macsy/.tern-project

ADD emacs /home/macsy/.emacs


RUN echo 'export ALTERNATE_EDITOR=""' >> $HOME/.bashrc
RUN echo 'export EDITOR=emacsclient' >> $HOME/.bashrc
RUN echo "alias emacs='emacsclient -t'" >> $HOME/.bashrc


VOLUME /data  


#ENTRYPOINT ["/entry.sh"]
ENTRYPOINT ["/usr/bin/emacs", "--daemon"]