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
                    git \
                    libffi-dev \
                    libsqlite3-dev \
                    libssl-dev \
                    libxml2-dev \
                    libxslt1-dev \
                    libyaml-dev \
                    nikto \
                    nmap \
                    nsis \
                    openssh-client \
                    openvas \
                    openvas-smb \
                    psmisc \
                    python \
                    python2.7-dev \
                    python-paramiko \
                    rpm \
                    rsync \
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
    wget https://bootstrap.pypa.io/ez_setup.py -O - | python && \
    wget https://bootstrap.pypa.io/get-pip.py -O - | python && \
    pip install chardet==2.1.1 \
                cluster==1.1.1b3 \
                darts.util.lru==0.5 \
                esmre==0.3.1 \
                Flask==0.10.1 \
                futures==2.1.5 \
                GitPython==0.3.2.RC1 \
                guess-language==0.2 \
                halberd==0.2.4 \
                Jinja2==2.7.3 \
                lxml==3.4.4 \
                markdown==2.6.1 \
                mitmproxy==0.13 \
                msgpack-python==0.4.4 \
                ndg-httpsclient==0.3.3 \
                nltk==3.0.1 \
                pdfminer==20140328 \
                Pexpect \
                phply==0.9.1 \
                psutil==2.2.1 \
                pyasn1==0.1.8 \
                pybloomfiltermmap==0.3.14 \
                pyClamd==0.3.15 \
                PyGithub==1.21.0 \
                pyOpenSSL==0.15.1 \
                python-ntlm==1.0.1 \
                PyYAML==3.11 \
                requests \
                ruamel.ordereddict==0.4.8 \
                scapy-real==2.2.0-dev \
                tblib==0.2.0 \
                termcolor==1.1.0 \
                tldextract==1.7.2 \
                vulndb==0.0.19 && \
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
        python setup.py install && \
    cd /osp/ospd-debsecan-1.0.0 && \
        python setup.py install && \
    cd /osp/ospd-ovaldi-1.0.0 && \
        python setup.py install && \
    cd /osp/ospd-paloalto-1.0b1 && \
        python setup.py install && \
    cd /osp/ospd-w3af-1.0.0 && \
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
    openvas-certdata-sync && \
    openvasmd --create-scanner="OSP w3af" --scanner-host=127.0.0.1 --scanner-port=9392 --scanner-type="OSP" && \
    cd / && \
    git clone https://github.com/andresriancho/w3af.git && \
    sed -i "s/'python-pip', //g" /w3af/w3af/core/controllers/dependency_check/platforms/ubuntu1204.py && \
    sed -i "s/'python-setuptools', //g" /w3af/w3af/core/controllers/dependency_check/platforms/ubuntu1204.py && \
    mkdir ~/.w3af/ && \
    printf "[STARTUP_CONFIG]\nauto-update = false\naccepted-disclaimer = true\n" >  ~/.w3af/startup.conf && \
    ln -s /w3af/w3af_console /usr/local/bin/w3af_console
	
CMD ["/openvas/start.sh"]

# Expose UI
EXPOSE 443 9390 9391
