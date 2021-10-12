alias d="gio trash"
alias n="nvim"
alias dh="$DOTPATH/local/bin/system/dothelper"
alias yd="youtube-dl --write-sub --write-auto-sub -o '~/Downloads/%(title)s-%(id)s.%(ext)s'"
alias ydl="youtube-dl --yes-playlist --write-sub --write-auto-sub -o '~/Downloads/%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s'"
alias ls='exa -a --color=always --group-directories-first' # all files and dirs
alias la='exa -al --color=always --group-directories-first' # my preferred listing
alias ll='exa -lu --color=always --group-directories-first --no-user --no-permissions -@'  # long format
alias lt='exa -aT --color=always --git-ignore -I=.git --group-directories-first' # tree listing
alias tcl="sudo rm -rf {$XDG_DATA_HOME/Trash,/media/HDD/.Trash}/{files,info}/{*,.*}"
alias np="unset {HTTP_PROXY,HTTPS_PROXY}"
alias sn="sudoedit"
alias yarn='yarn --use-yarnrc "$XDG_CONFIG_HOME/yarnrc"'
alias y='yarn'
alias rs="rsync"
alias rsa="rsync -avz"
alias -g B="| bat"
alias -g F="| fzf"
alias -g G="| rg"
alias -g NE="2>/dev/null"
alias -g NUL=">/dev/null 2>&1"
alias -g S="| sort -n -r"
alias -g W="| wc -l"

g() {
  if [[ -z $@ ]]; then
    git rev-parse --is-inside-work-tree NUL && emacsclient -e '(magit-status-here)'
  else git $@; fi
}
mc() { mkdir -p $@ && cd ${@:$#}; } # make a dir and cd into it
man() { emacsclient -n -e "(man \"$1\")"; }
pau() {
  local res=($(pacman -Qeq | fzf -m --preview="paru -Qi {}"))
  [[ -n $res ]] && for i in $res; do paru -Rns $i; done
}
pai() {
  local bind="f5:preview(paru -Gp {} | bat -fpl sh)"
  local pkglist="{ cat ~/.cache/paru/packages.aur; pacman -Ssq; } | sort -u"
  local fzf_cmd="fzf -m --height=100% --bind=\"$bind\" --preview=\"paru -Si {}\""
  res=(`eval $pkglist | eval $fzf_cmd`)
  [[ -n "$res" ]] && for i in $res; do paru $@ $i; done
}
