FROM ubuntu:latest
MAINTAINER John Pape <jtpape@us.ibm.com>

ADD bmx-cli.tgz /bmx-cli
ADD cf.tgz /cf
ADD https://openwhisk.ng.bluemix.net/cli/go/download/linux/amd64/wsk /wsk
ADD entry.sh /entry.sh
RUN chmod +x /entry.sh

RUN /bmx-cli/Bluemix_CLI/install_bluemix_cli
RUN chmod +x /cf/cf
RUN chmod +x /wsk

ENTRYPOINT ["/entry.sh"]