FROM alpine:latest

ENV GOPATH=/root/go

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    apk update && \
    apk upgrade && \
    apk add --no-cache bash \
      # clang clang-dev clang-static \
      curl \
      gcc \
      git \
      go \
      musl-dev \
      neovim \
      neovim-doc \
      neovim-lang \
      nodejs \
      nodejs-npm \
      # php7 php7-tidy \
      python3 python3-dev \
      the_silver_searcher tidyhtml yarn && \
    rm -rf /var/cache/apk/* && \
    mkdir -p $HOME/.config/nvim && mkdir -p $HOME/workspace && \
    pip3 install astroid isort neovim pylint && \
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && \
    npm install -g eslint standard jsonlint stylelint stylelint-scss

COPY init.vim /root/.config/nvim

RUN nvim -i NONE -c PlugInstall -c quitall > /dev/null 2>&1 && \
    nvim -i NONE -c UpdateRemotePlugins -c quitall > /dev/null 2>&1 && \
    sed -i'' -e "s/\" colorscheme onedark/colorscheme onedark/" /root/.config/nvim/init.vim && \
    ~/.fzf/install

WORKDIR $HOME/workspace

CMD ["/bin/sh"]
