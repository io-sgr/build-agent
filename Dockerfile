FROM ubuntu:22.04

SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get install -y \
      curl \
      unzip \
      zip \
      git && \
    rm -rf /var/lib/apt/lists/*

RUN curl -s "https://get.sdkman.io" | bash && \
    sed -i 's/sdkman_auto_answer=false/sdkman_auto_answer=true/g'                $HOME/.sdkman/etc/config && \
    sed -i 's/sdkman_selfupdate_feature=true/sdkman_selfupdate_feature=false/g'  $HOME/.sdkman/etc/config && \
    sed -i 's/sdkman_colour_enable=true/sdkman_colour_enable=false/g'            $HOME/.sdkman/etc/config && \
    echo 'source $HOME/.sdkman/bin/sdkman-init.sh' >> $HOME/.bash_profile

RUN source $HOME/.bash_profile && \
    sdk install java 8.0.265-open && \
    sdk install java 11.0.12-open && \
    sdk install java 17.0.2-open && \
    sdk install java 21.0.2-open && \
    sdk default java 21.0.2-open && \
    sdk flush

RUN git clone https://github.com/jenv/jenv.git $HOME/.jenv && \
    echo 'export PATH="$HOME/.jenv/bin:$PATH"' >> $HOME/.bash_profile && \
    echo 'eval "$(jenv init -)"' >> $HOME/.bash_profile

RUN source $HOME/.bash_profile && \
    jenv add $HOME/.sdkman/candidates/java/8.0.265-open && \
    jenv add $HOME/.sdkman/candidates/java/11.0.12-open && \
    jenv add $HOME/.sdkman/candidates/java/17.0.2-open && \
    jenv add $HOME/.sdkman/candidates/java/21.0.2-open && \
    jenv global 21.0.2 && \
    jenv enable-plugin maven && \
    jenv enable-plugin export

ADD ./docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
