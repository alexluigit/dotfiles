[[ -d $ZSH_DATA_DIR/plugins ]] || mkdir -p $ZSH_DATA_DIR/plugins

_zsh_install_plugins() {
  local zsh_plugins=(romkatv/zsh-defer
                     rupa/z
                     zsh-users/zsh-autosuggestions
                     zsh-users/zsh-syntax-highlighting)
  for plugin in ${zsh_plugins[@]}; do
    local plug_dirname=$(awk -F/ '{print $2}' <<< "$plugin")
    local plug_dir=$ZSH_DATA_DIR/plugins/$plug_dirname
    [[ -d $plug_dir ]] || {
      mkdir -p $plug_dir
      local host="github.com"
      local url="https://$host/$plugin"
      cd $ZSH_DATA_DIR/plugins; git clone $url; cd -
    }
  done
  [[ -n $@ ]] && echo "Plugin updated, restart your teminal to apply";
}
_zsh_update_plugins() { rm -rf $ZSH_DATA_DIR/plugins; _zsh_install_plugins 1; }

_zsh_install_plugins

# Setting up plugins
_Z_DATA=${XDG_DATA_HOME:-~/.local/share}/zsh/z/zdata
ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=(forward-word)
declare -A ZSH_HIGHLIGHT_STYLES=(
  [alias]=fg=yellow,bold
  [builtin]=fg=blue,bold
  [function]=fg=yellow,bold
  [command]=fg=blue,bold
)

# Load completions / plugins
. $ZSH_DATA_DIR/plugins/zsh-defer/zsh-defer.plugin.zsh
zsh-defer . /usr/share/fzf/completion.zsh
zsh-defer . /opt/homebrew/opt/fzf/shell/completion.zsh
zsh-defer . $ZSH_DATA_DIR/plugins/z/z.sh
zsh-defer . $ZSH_DATA_DIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
zsh-defer . $ZSH_DATA_DIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
