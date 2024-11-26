packages                                        \
  apt:vim                                       \
  msys:vim                                      \
  choco:vim                                     \
  yay:gvim-git                                  \
  pacman:vim

link                                            \
  "$XDG_CONFIG_HOME/vim/init.vim"               \
  "$XDG_CONFIG_HOME/vim/plugs.vim"              \

link-to "$XDG_CONFIG_HOME/vim/colors" ./colors/*
link-to "$XDG_CONFIG_HOME/vim/mods" ./mods/*
link-to "$XDG_CONFIG_HOME/vim/plugs" ./plugs/*

if ! [ -e "$XDG_CONFIG_HOME/vim/autoload/plug.vim" ]; then
  info 'Installing VIM Plugged'
  run-cmds <<-"EOF"
if hash nvim 2>/dev/null; then vim=nvim; else vim=vim; fi

# For some dumb reason, you can't change where the autoload directory is.
autoload_path="$XDG_CONFIG_HOME/vim/autoload/plug.vim"
autoload_url='https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
if ! [ -f "$autoload_path" ]; then
  curl -fLo "$autoload_path" --create-dirs "$autoload_url"
else
  true
fi && "$vim" -n -e +PlugInstall +qall!
EOF
fi
