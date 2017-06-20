FROM alpine:latest

ENV GOPATH=/root/go

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    apk update && \
    apk upgrade && \
    apk add --no-cache bash clang clang-dev clang-static curl gcc git go musl-dev neovim \
      neovim-doc neovim-lang nodejs nodejs-npm \
      # php7 php7-tidy \
      python3 python3-dev \
      the_silver_searcher tidyhtml yarn && \
    rm -rf /var/cache/apk/* && \
    mkdir -p $HOME/.config/nvim && mkdir -p $HOME/workspace && \
    pip3 install astroid isort neovim pylint && \
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && \
    go get github.com/nsf/gocode && \
    go get github.com/alecthomas/gometalinter && \
    go get golang.org/x/tools/cmd/goimports && \
    go get golang.org/x/tools/cmd/guru && \
    go get golang.org/x/tools/cmd/gorename && \
    go get github.com/golang/lint/golint && \
    go get github.com/rogpeppe/godef && \
    go get github.com/kisielk/errcheck && \
    go get github.com/jstemmer/gotags && \
    go get github.com/klauspost/asmfmt/cmd/asmfmt && \
    go get github.com/fatih/motion && \
    go get github.com/fatih/gomodifytags && \
    go get github.com/zmb3/gogetdoc && \
    go get github.com/josharian/impl && \
    go get github.com/dominikh/go-tools/cmd/keyify && \
    npm install -g eslint standard jsonlint stylelint stylelint-scss

COPY init.vim /root/.config/nvim

RUN nvim -i NONE -c PlugInstall -c quitall > /dev/null 2>&1 && \
    nvim -i NONE -c UpdateRemotePlugins -c quitall > /dev/null 2>&1 && \
    sed -i'' -e "s/\" colorscheme onedark/colorscheme onedark/" /root/.config/nvim/init.vim && \
    ~/.fzf/install

WORKDIR $HOME/workspace

CMD ["/bin/sh"]
