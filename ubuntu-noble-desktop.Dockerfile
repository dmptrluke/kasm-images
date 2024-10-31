FROM docker.io/kasmweb/ubuntu-noble-desktop:%VER%-rolling-weekly
ARG TARGETARCH

USER root

RUN apt update && apt install -y dbus dbus-broker dnsutils iputils-ping wget zsh git curl zoxide fzf bat


WORKDIR /tmp
# https://hub.docker.com/r/rustlang/rust/dockerfile
ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    USER=root \
    PATH=/usr/local/cargo/bin:$PATH

# install rust
RUN set -eux; \
    \
    url="https://sh.rustup.rs"; \
    wget "$url" -O rustup-init; \
    chmod +x rustup-init; \
    ./rustup-init -y --no-modify-path; \
    rm rustup-init; \
    chmod -R a+w $RUSTUP_HOME $CARGO_HOME; \
    rustup --version; \
    cargo --version; \
    rustc --version;

# install 1password
RUN if [ "$TARGETARCH" = "amd64" ]; then \ 
    wget https://downloads.1password.com/linux/debian/amd64/stable/1password-latest.deb && sudo apt install ./1password-latest.deb -y; \
    fi

USER 1000

# set default shell
RUN sudo usermod -s /bin/zsh kasm-user
WORKDIR /home/kasm-user
