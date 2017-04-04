GIT_EMAIL=""
GIT_NAME=""
GIT_TOKEN=""

# Install prereq Ubuntu packages
sudo apt-get update && sudo apt-get install -y openjdk-8-jdk xvfb build-essential cmake python-dev python3-dev apt-transport-https ca-certificates curl software-properties-common bison mercurial make binutils gcc golang

# Install the CF CLI
cp ./cf.tgz /tmp/cf.tgz
cd /tmp && tar xvfz cf.tgz && sudo mv /tmp/cf /usr/local/bin/cf && cd -
sudo chmod +x /usr/local/bin/cf

# Install the BMX CLI
cp ./bmx-cli.tgz /tmp/bmx-cli.tgz
cd /tmp && tar xvfz bmx-cli.tgz && cd /tmp/Bluemix_CLI && sudo ./install_bluemix_cli && cd -

# Get Docker going
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository  "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs)  stable"
sudo apt-get update && sudo apt-get install -y docker-ce

#Get OpenWhisk CLI
wget "https://openwhisk.ng.bluemix.net/cli/go/download/linux/amd64/wsk"
chmod +x wsk && sudo mv wsk /usr/local/bin/wsk

#Add some Git default config
git config --global user.email "$GIT_EMAIL"
git config --global user.name "$GIT_NAME"

#Set up the projects folder
mkdir -p /home/jtpape/projects/node
mkdir -p /home/jtpape/projects/java
mkdir -p /home/jtpape/projects/go
mkdir -p /home/jtpape/projects/ruby
mkdir -p /home/jtpape/projects/python
mkdir -p /home/jtpape/che

# Install grab Eclipse and Eclin and start it up
cd ~
wget "http://eclipse.mirror.rafal.ca/technology/epp/downloads/release/neon/2/eclipse-jee-neon-2-linux-gtk-x86_64.tar.gz"
wget "https://github.com/ervandew/eclim/releases/download/2.6.0/eclim_2.6.0.jar"
tar -zxf eclipse-jee-neon-2-linux-gtk-x86_64.tar.gz
echo "osgi.instance.area.default=@user.home/projects/java" >> ~/.eclimrc
Xvfb :1 -screen 0 1024x768x24 &
java -Dvim.files=$HOME/.vim -Declipse.home=/home/jtpape/eclipse -jar eclim_2.6.0.jar install
cd eclipse && DISPLAY=:1 ./eclipse/eclimd -b && cd -

# Get Nave going for Node.js
cd ~
curl https://raw.githubusercontent.com/isaacs/nave/master/nave.sh > ~/nave.sh
chmod +x ~/nave.sh && sudo ln -s /home/jtpape/nave.sh /usr/local/bin/nave
sudo nave usemain 6.9.5

# Get the tern.js project file in place
cd /home/jtpape/macsy
cp tern-project /home/jtpape/.tern-project

# Set up emacs
sudo add-apt-repository -y ppa:ubuntu-elisp
sudo apt-get update
sudo apt-get install emacs-snapshot
cp emacs /home/jtpape/.emacs

# ensure we have some eslint dependencies
sudo npm install -g eslint
sudo npm install -g babel-eslint

# Shell fix-ups
echo PATH="$HOME/bin:$HOME/.local/bin:/usr/local/go/bin:/home/jtpape/projects/go/bin:$PATH" >> /home/jtpape/.profile
echo "export GHE_TOKEN=$GIT_TOKEN" >> /home/jtpape/.profile
echo "export GOPATH=/home/jtpape/projects/go" >> /home/jtpape/.profile
mkdir ~/.bash
cd ~/.bash
git clone git://github.com/jimeh/git-aware-prompt.git
echo "export GITAWAREPROMPT=~/.bash/git-aware-prompt" >> /home/jtpape/.bashrc
echo "source \"${GITAWAREPROMPT}/main.sh\"" >> /home/jtpape/.bashrc
echo 'export PS1="\${debian_chroot:+(\$debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "' >> /home/jtpape/.bashrc

# TBD Eclipse Che
sudo chmod ugo+rwx /var/run/docker.sock
docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock -v /home/jtpape/che:/data eclipse/che start
