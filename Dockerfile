FROM centos:7

ENV PACKER_VERSION=1.2.3

RUN groupadd cicd -g 5000 && \
    useradd -g cicd -m -u 1000 cicd

RUN yum update -y && \
    yum install -y epel-release && \
    yum install -y \
        sudo \
        gcc \
        git \
        unzip \
        python-pip \
        python-wheel \
        openssh-clients && \
    yum clean metadata && \
    pip install awscli boto boto3 ansible && \
    echo 'cicd ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN curl -o /tmp/packer.zip https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip && \
    unzip /tmp/packer.zip -d /usr/local/bin

USER 1000

ENTRYPOINT ["/usr/local/bin/packer"]
CMD ["version"]
