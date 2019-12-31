# History size
HISTSIZE=10000
SAVEHIST=10000
# Load aliases and shortcuts if existent.
[ -f "$HOME/.config/zsh/keybindrc" ] && source "$HOME/.config/zsh/keybindrc"
[ -f "$HOME/.config/zsh/aliasrc" ] && source "$HOME/.config/zsh/aliasrc"
# Quit vifm and change dir
vicd()
{
    local dst="$(command vifm --choose-dir - "$@")"
    if [ -z "$dst" ]; then
        echo 'Directory picking cancelled/failed'
        return 1
    fi
    cd "$dst"
}
# ZSH
export ZSH="$HOME/.config/oh-my-zsh"
ZSH_THEME="gitster"
export TERM="xterm-256color"
source $ZSH/oh-my-zsh.sh
# Plugins
plugins=(git)
# CleanUp
compinit -d ~/.cache/zsh/zcompdump-$ZSH_VERSION
HISTFILE=~/.cache/zsh/history
# Locale
export LC_ALL=en_US.utf-8
export LANG="$LC_ALL"
# Fzf init
[ -f ~/.config/zsh/.fzf.zsh ] && source ~/.config/zsh/.fzf.zsh
export FZF_DEFAULT_OPTS="--no-mouse --height 40% -1 --reverse --multi --inline-info --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' --preview-window='right:hidden:wrap' --bind 'f2:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept'"
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!{.git,node_modules}'"
# Reset cursor shape after every command
reset-cursor() {
  printf '\033]50;CursorShape=1\x7'
}
export PS1="$(reset-cursor)$PS1"
# Syntax highlighting man page
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
# Put this line in the end
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

