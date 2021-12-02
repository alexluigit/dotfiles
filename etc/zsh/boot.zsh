[[ -d $ZSH_DATA_DIR/plugins ]] || mkdir -p $ZSH_DATA_DIR/plugins

install_plugins() {
  PLUGINS+=(romkatv/zsh-defer)
  for plugin in ${PLUGINS[@]}; do
    local plug_dirname=$(awk -F/ '{print $2}' <<< "$plugin")
    local plug_dir=$ZSH_DATA_DIR/plugins/$plug_dirname
    [[ -d $plug_dir ]] || {
      mkdir -p $plug_dir
      local host="github.com"
      local url="https://$host/$plugin"
      cd $ZSH_DATA_DIR/plugins; git clone $url; cd -
    }
  done
  source $ZSH_DATA_DIR/plugins/zsh-defer/zsh-defer.plugin.zsh
}

update-plugins() { rm -rf $ZSH_DATA_DIR/plugins; zsh; }

install_plugins

# Init beam shape cursor before every cmd
zle-line-init() { echo -ne "\e[5 q"; } # '|' cursor
zle -N zle-line-init
preexec_functions+=(zle-line-init)

vterm_printf(){ printf "\e]%s\e\\" "$1"; } # vterm (emacs) helper
