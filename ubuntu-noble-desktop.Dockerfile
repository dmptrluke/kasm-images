FROM docker.io/kasmweb/ubuntu-noble-desktop:%VER%-rolling-weekly
ARG TARGETARCH
USER root

ENV HOME=/home/kasm-default-profile
ENV STARTUPDIR=/dockerstartup
ENV INST_SCRIPTS=$STARTUPDIR/install
WORKDIR $HOME

## START CUSTOMISATION

# Install software
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    dbus dbus-broker dnsutils iputils-ping wget zsh git curl \
    zoxide fzf bat python3-pip python3-bs4 python3-venv \
    thunar-archive-plugin jq gnupg2 xfce4-taskmanager \
    unzip ca-certificates && \
    apt-get clean && \
    rm -rf /var/cache/apt/archives /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install fonts
COPY ./src/install_fonts.sh $INST_SCRIPTS/fonts/
RUN bash $INST_SCRIPTS/fonts/install_fonts.sh && \
    rm -rf $INST_SCRIPTS/fonts/ /tmp/*

# Install Rust
WORKDIR /tmp
# https://hub.docker.com/r/rustlang/rust/dockerfile
ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    USER=root \
    PATH=/usr/local/cargo/bin:$PATH

RUN set -eux; \
    \
    url="https://sh.rustup.rs"; \
    wget -q "$url" -O rustup-init; \
    chmod +x rustup-init; \
    ./rustup-init -y --no-modify-path --default-toolchain stable; \
    rm rustup-init; \
    chmod -R a+w $RUSTUP_HOME $CARGO_HOME; \
    rustup --version; \
    cargo --version; \
    rustc --version; \
    rm -rf /tmp/*

# Install 1Password
RUN if [ "$TARGETARCH" = "amd64" ]; then \
    wget -q https://downloads.1password.com/linux/debian/amd64/stable/1password-latest.deb && \
    dpkg -i ./1password-latest.deb || apt-get install -f -y && \
    rm -f 1password-latest.deb; \
    fi

# Set default shell
RUN chsh -s /bin/zsh kasm-user

# Add .zshrc
COPY ./src/.zshrc $HOME

######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME=/home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000

