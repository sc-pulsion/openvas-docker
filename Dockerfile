# OpenVAS

FROM ubuntu:14.04
MAINTAINER Mike Splain mike.splain@gmail.com

COPY bin/start.sh /openvas/
COPY config/redis.config /etc/redis/

RUN apt-get update && \
    apt-get install software-properties-common -yq && \
    add-apt-repository ppa:mikesplain/openvas -y && \
    add-apt-repository ppa:mrazavi/openvas -y && \
    apt-get update && \
    apt-get install alien \
                    dirb \
                    dnsutils \
                    fakeroot \
                    nikto \
                    nmap \
                    nsis \
                    openssh-client \
                    openvas \
                    openvas-smb \
                    psmisc \
                    python \
                    python-paramiko \
                    python-pip \
                    python-setuptools \
                    rpm \
                    rsync \
                    scp \
                    sendmail \
                    smbclient \
                    socat \
                    sqlite3 \
                    sshpass \
                    texlive-latex-base \
                    texlive-latex-extra \
                    texlive-latex-recommended \
                    wapiti \
                    wget \
                    xmlstarlet \
                    xsltproc \
                    zip \
                    -yq && \
    mkdir /osp && \
    cd /osp && \
        wget http://wald.intevation.org/frs/download.php/1999/ospd-1.0.0.tar.gz && \
        wget http://wald.intevation.org/frs/download.php/2145/ospd-1.0.1.tar.gz && \
        wget http://wald.intevation.org/frs/download.php/2177/ospd-1.0.2.tar.gz && \
        wget http://wald.intevation.org/frs/download.php/2005/ospd-ancor-1.0.0.tar.gz && \
        wget http://wald.intevation.org/frs/download.php/2097/ospd-debsecan-1.0.0.tar.gz && \
        wget http://wald.intevation.org/frs/download.php/2003/ospd-ovaldi-1.0.0.tar.gz && \
        wget http://wald.intevation.org/frs/download.php/2149/ospd-paloalto-1.0b1.tar.gz && \
        wget http://wald.intevation.org/frs/download.php/2004/ospd-w3af-1.0.0.tar.gz && \
        wget http://wald.intevation.org/frs/download.php/2181/ospd-acunetix-1.0b1.tar.gz && \
        wget http://wald.intevation.org/frs/download.php/2185/ospd-ikescan-1.0b1.tar.gz && \
        wget http://wald.intevation.org/frs/download.php/2204/ospd-ikeprobe-1.0b1.tar.gz && \
        wget http://wald.intevation.org/frs/download.php/2213/ospd-ssh-keyscan-1.0b1.tar.gz && \
        wget http://wald.intevation.org/frs/download.php/2219/ospd-netstat-1.0b1.tar.gz && \
        tar zxvf ospd-1.0.0.tar.gz && \
        tar zxvf ospd-1.0.1.tar.gz && \
        tar zxvf ospd-1.0.2.tar.gz && \
        tar zxvf ospd-ancor-1.0.0.tar.gz && \
        tar zxvf ospd-debsecan-1.0.0.tar.gz && \
        tar zxvf ospd-ovaldi-1.0.0.tar.gz && \
        tar zxvf ospd-paloalto-1.0b1.tar.gz && \
        tar zxvf ospd-w3af-1.0.0.tar.gz && \
        tar zxvf ospd-acunetix-1.0b1.tar.gz && \
        tar zxvf ospd-ikescan-1.0b1.tar.gz && \
        tar zxvf ospd-ikeprobe-1.0b1.tar.gz && \
        tar zxvf ospd-ssh-keyscan-1.0b1.tar.gz && \
        tar zxvf ospd-netstat-1.0b1.tar.gz && \
    cd /osp/ospd-1.0.0 && \
        python setup.py install && \
    cd /osp/ospd-1.0.1 && \
        python setup.py install && \
    cd /osp/ospd-1.0.2 && \
        python setup.py install && \
    cd /osp/ospd-ancor-1.0.0 && \
        pip install requests && \
        python setup.py install && \
    cd /osp/ospd-debsecan-1.0.0 && \
        python setup.py install && \
    cd /osp/ospd-ovaldi-1.0.0 && \
        python setup.py install && \
    cd /osp/ospd-paloalto-1.0b1 && \
        python setup.py install && \
    cd /osp/ospd-w3af-1.0.0 && \
        pip install Pexpect && \
        python setup.py install && \
    cd /osp/ospd-acunetix-1.0b1 && \
        python setup.py install && \
    cd /osp/ospd-ikescan-1.0b1  && \
        python setup.py install && \
    cd /osp/ospd-ikeprobe-1.0b1 && \
        python setup.py install && \
    cd /osp/ospd-ssh-keyscan-1.0b1 && \
        python setup.py install && \
    cd /osp/ospd-netstat-1.0b1 && \
        python setup.py install && \
    cd /tmp && \
    wget https://github.com/Arachni/arachni/releases/download/v1.4/arachni-1.4-0.5.10-linux-x86_64.tar.gz && \
        tar -zxvf arachni-1.4-0.5.10-linux-x86_64.tar.gz && \
        mv arachni-1.4-0.5.10 /opt/arachni && \
        ln -s /opt/arachni/bin/* /usr/local/bin/ && \
    rm -rf /tmp/arachni* && \
    mkdir -p /var/lib/openvas/scap-data/private && \
    wget https://svn.wald.intevation.org/svn/openvas/trunk/tools/openvas-check-setup --no-check-certificate -O /openvas/openvas-check-setup && \
    chmod a+x /openvas/openvas-check-setup && \
    chmod a+x /openvas/start.sh && \
    apt-get autoremove -yq && \
    rm -rf /var/lib/apt/lists/* && \
	mkdir -p /var/run/redis && \
	redis-server /etc/redis/redis.config && \
	ldconfig && \
	openvas-mkcert -q && \
	openvas-mkcert-client -n -i && \
	openvas-nvt-sync && \
	openvas-scapdata-sync && \
	openvas-certdata-sync

CMD ["/openvas/start.sh"]

# Expose UI
EXPOSE 443 9390 9391
