FROM python:alpine

# COPY init.vim $HOME
# COPY run.sh /usr/local/bin

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
      apk update && \
      apk upgrade && \
      apk add --no-cache musl-dev gcc git neovim neovim-doc neovim-lang the_silver_searcher && \
      rm -rf /var/cache/apk/* && \
      # mkdir -p $HOME/.config/nvim && mv init.vim $HOME/.config/nvim && \
      pip install neovim

# CMD ["sh", "/usr/local/bin/run.sh"]
CMD ["nvim"]
