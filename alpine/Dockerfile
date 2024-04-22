FROM alpine:3.19

ENV JENV_DIR="/usr/local/jenv"

RUN apk --update add --no-cache \
        ca-certificates \
        curl \
        which \
        git \
        patch \
        bash \
        openjdk8-jdk \
        openjdk11-jdk \
        openjdk17-jdk \
        openjdk21-jdk \
        openssl-dev && \
    rm -rf /var/cache/apk/* && \
    git clone https://github.com/jenv/jenv.git /usr/local/jenv && \
    echo 'export PATH="$JENV_DIR/bin:$PATH"' >> /etc/profile.d/jenv.sh && \
    echo 'eval "$(jenv init -)"' >> /etc/profile.d/jenv.sh && \
    source /etc/profile.d/jenv.sh && \
    jenv add /usr/lib/jvm/java-8-openjdk/ && \
    jenv add /usr/lib/jvm/java-11-openjdk/ && \
    jenv add /usr/lib/jvm/java-17-openjdk/ && \
    jenv add /usr/lib/jvm/java-21-openjdk/ && \
    jenv global 21 && \
    rm -rf /tmp/*

SHELL ["/bin/bash", "-c"]

ADD docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["cat"]
