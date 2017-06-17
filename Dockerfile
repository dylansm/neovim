FROM alpine:latest

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    apk update && \
    apk upgrade && \
    apk add --no-cache curl musl-dev gcc git neovim neovim-doc neovim-lang python3 python3-dev the_silver_searcher && \
    rm -rf /var/cache/apk/* && \
    mkdir -p $HOME/.config/nvim && mkdir -p $HOME/workspace && \
    pip3 install neovim && \
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

COPY init.vim /root/.config/nvim

RUN nvim -i NONE -c PlugInstall -c quitall > /dev/null 2>&1 && \
    nvim -i NONE -c UpdateRemotePlugins -c quitall > /dev/null 2>&1 && \
    sed -i'' -e "s/\" colorscheme onedark/colorscheme onedark/" /root/.config/nvim/init.vim

WORKDIR $HOME/workspace

CMD ["/bin/sh"]
