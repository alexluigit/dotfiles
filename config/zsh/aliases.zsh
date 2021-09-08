alias d="gio trash"
alias n="nvim"
alias dh="~/Code/$USER.files/local/bin/system/dothelper"
alias yd="youtube-dl --write-sub --write-auto-sub -o '~/Downloads/%(title)s-%(id)s.%(ext)s'"
alias ydl="youtube-dl --yes-playlist --write-sub --write-auto-sub -o '~/Downloads/%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s'"
alias ka="killall"
alias ls='exa -a --color=always --group-directories-first' # all files and dirs
alias la='exa -al --color=always --group-directories-first' # my preferred listing
alias ll='exa -lu --color=always --group-directories-first --no-user --no-permissions -@'  # long format
alias lt='exa -aT --color=always --git-ignore -I=.git --group-directories-first' # tree listing
alias tcl="sudo rm -rf {$XDG_DATA_HOME/Trash,/media/HDD/.Trash}/{files,info}/{*,.*}"
alias np="unset {HTTP_PROXY,HTTPS_PROXY}"
alias sn="sudoedit"
alias y='yarn --use-yarnrc "$XDG_CONFIG_HOME/yarnrc"'
alias rs="rsync"
alias rsa="rsync -avz"
alias -g B="| bat"
alias -g F="| fzf"
alias -g G="| rg"
alias -g NE="2>/dev/null"
alias -g NUL=">/dev/null 2>&1"
alias -g S="| sort -n -r"
alias -g W="| wc -l"

_inside_git_repo() { git rev-parse --is-inside-work-tree >/dev/null 2>&1; }
_magit() { emacsclient -e '(magit-status-here)'; }
_fzf_paru_Rns() {
  local res=($(pacman -Qeq | fzf -m --preview="paru -Qi {}"))
  [[ -n $res ]] && paru -Rns $res
}
_fzf_paru_S() {
  local pkgs=~/.local/share/paru/pkglist
  local bind="f5:preview(paru -Gp {} | bat -fpl sh)"
  local res=(`fzf -m --height=100% --bind="$bind" --preview="paru -Si {}" < $pkgs`)
  local emacs_paru="~/.cache/paru/clone/emacs-git"
  [[ $res == "emacs-git" ]] && {
    paru $@ $res
    eval "git clone -s $emacs_paru/emacs-git $emacs_paru/src/emacs-git"
  } || { [[ -n "$res" ]] && paru $@ $res; }
}

g() { [[ -z $@ ]] && _inside_git_repo && _magit || git $@; }
mc() { mkdir -p $@ && cd ${@:$#}; } # make a dir and cd into it
pai() { _fzf_paru_S $@; }
pau() { _fzf_paru_Rns; }
