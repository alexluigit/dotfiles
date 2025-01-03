alias d="gio trash"
alias dh="/opt/dotfiles/local/bin/linux/dothelper"

# Package management
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
paru() {
  updates=$(pacman -Qu)
  /usr/bin/paru $@ && echo $updates > ~/.cache/paru/last_update.txt # for rollback
}
