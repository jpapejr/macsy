FROM ubuntu:latest
MAINTAINER John Pape <jpapejr@icloud.com>

ENV GITAWAREPROMPT "/root/git-aware-prompt"

RUN apt-get update && apt-get install -y git bash acl \
    && git clone git://github.com/jimeh/git-aware-prompt.git /root/git-aware-prompt\
    && echo "source $GITAWAREPROMPT/main.sh" >> /root/.bashrc \
    && echo 'export PS1="\${debian_chroot:+(\$debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "' >> /root/.bashrc \
    && apt-get autoremove -y \
    && apt-get clean autoclean \
    && rm -rf /var/lib/{apt,dpkg,cache,log}

ADD entry.sh /entry.sh
RUN chmod +x /entry.sh

WORKDIR /projects

ENTRYPOINT ["/entry.sh"]