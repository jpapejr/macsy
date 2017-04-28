# macsy
Bootstrapping a VM for my dev flow

Installation/Start-up sequence

1. `docker-compose up eclipse-eclim utils`
2. `docker-compose up -d code`
3. `docker-compomse up -d emacs`


## Shell Fix-ups

To make things easier, here are some aliases and other helpful things to add to the shell to make life with Macsy easier. (Assumes bash in all cases unless noted otherwise)


### .bashrc
alias emacs='docker-compose exec emacs emacs'
alias code='docker exec -it -e GHE_TOKEN=$GHE_TOKEN macsy_code_1 /bin/bash'
export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin
export GHE_TOKEN=<git personal access token> _

### useful apps/packages
- build essentials (yum groupinstall "Development Tools" | apt-get install build-essential)
- ngrok (https://ngrok.com/)
- gotty (go get github.com/yudai/gotty)
- tmux (https://tmux.github.io/)
- mosh (https://mosh.org/) - With RHEL, need to enable EPEL and install
- docker (docker.io)
  >sudo yum install -y yum-utils
  >sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
  >sudo yum makecache fast
  >sudo yum -y install docker-ce
  >systemctl start docker
  >add self to `docker` group
- docker-compose (curl -L https://github.com/docker/compose/releases/download/1.12.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose)