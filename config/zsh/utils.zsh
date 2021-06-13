_inside_git_repo() { git rev-parse --is-inside-work-tree >/dev/null 2>&1; }
_fugitive() { nvim -c "Gstatus | bd# | nmap <buffer>q <c-w>q"; }
_resume_jobs() { fg; zle reset-prompt; zle-line-init; }
_updir() { cd ..; zle reset-prompt; }
_yank_cmdline() { echo -n "$BUFFER" | xclip -selection clipboard; }
declare -gA AUTOPAIR_PAIRS=('`' '`' "'" "'" '"' '"' '{' '}' '[' ']' '(' ')' '<' '>' ' ' ' ')
_autopairs() {
  local pair
  [ $1 == 'a' ] && pair='<'
  [ $1 == 'b' ] && pair='('
  [ $1 == 'r' ] && pair='['
  [ $1 == 'c' ] && pair='{'
  [ $1 == 'q' ] && pair="'"
  [ $1 == 'Q' ] && pair='"'
  RBUFFER=$pair$AUTOPAIR_PAIRS[$pair]$RBUFFER
  zle forward-char
}
_lf() {
  [[ $INSIDE_EMACS == vterm ]] && emacsclient -e '(lf)' >/dev/null || \
  emacsclient -nc -F '(list (name . "lf-emacs"))' -e "(lf \"$PWD/\")" >/dev/null
}
_sudo_edit() {
  tmp_file=`mktemp --dry-run`
  cp "$1" "$tmp_file"
  nvim $tmp_file
  doas mv "$tmp_file" "$1"
}
_fzf_hist() {
  setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases
  local sel num
  sel=($(fc -rl 1 | fzf +m))
  [[ -n "$sel" ]] && { num=$sel[1]; [[ -n "$num" ]] && zle vi-fetch-history -n $num; }
  zle reset-prompt
}
_fzf_cd() { local sel=$(fd -c always -td . | fzf --ansi); [[ -n $sel ]] && cd $sel; zle reset-prompt; }
_fzf_comp_helper() { BUFFER="$BUFFER**"; zle end-of-line; fzf-completion; }
_fzf_kill() { BUFFER="kill -9 "; zle end-of-line; fzf-completion; }
_fzf_paru_Rns() {
  local res=($(pacman -Qeq | fzf -m --preview="paru -Si {}"))
  [[ -n $res ]] && paru -Rns $res
}
_fzf_paru_S() {
  local pkgs=~/.local/share/paru/pkglist
  local bind="f5:preview(paru -Gp {} | bat -fpl sh)"
  local res=(`fzf -m --height=100% --bind="$bind" --preview="paru -Si {}" < $pkgs`)
  local emacs_paru="~/.cache/paru/clone/emacs-git"
  [[ $res == "emacs-git" ]] && {
    eval "rm -rf $emacs_paru/src"
    paru $@ $res
    eval "git clone -s $emacs_paru/emacs-git $emacs_paru/src/emacs-git"
  } || { [[ -n "$res" ]] && paru $@ $res; }
}
