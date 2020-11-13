stty -ixon # Disable XON/XOFF flow control
bindkey -v # vi-mode

# Better vi-mode
for m in visual viopp; do
  for c in {a,i}{\',\",\`}; do; bindkey -M $m $c select-quoted; done
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do; bindkey -M $m $c select-bracketed; done
done

bindkey -a            'cs'       change-surround
bindkey -a            'ds'       delete-surround
bindkey -a            'ys'       add-surround
bindkey -a            \'         vi-forward-char
bindkey -M vicmd      'k'        up-line-in-buffer # Do not go search history
bindkey -M visual     'S'        add-surround
bindkey -M menuselect 'h'        vi-backward-char
bindkey -M menuselect 'e'        vi-up-line-or-history
bindkey -M menuselect  \'        vi-forward-char
bindkey -M menuselect 'n'        vi-down-line-or-history

# Functions
# See keylist at https://www.zsh.org/mla/users/2014/msg00266.html
bindkey               '^a'       fzf-dirstack
bindkey               '^b'       backward-char
bindkey               '^k'       newnote-or-edit-cmd
bindkey               '^f'       file-or-forwardchar
bindkey               '^[[17~'   bol-or-inside # <C-i> -> F6
bindkey               '^n'       up-line-or-beginning-search
bindkey               '^e'       down-line-or-beginning-search
bindkey               '^l'       clear-or-complete
bindkey               '^j'       fzf-note
bindkey               '^o'       eol-or-updir
bindkey               "^[OR'"    fzf-dev-vid
bindkey               "^[OR^[OR" fzf-dev-vid
bindkey               '^[ORn'    fzf-note
bindkey               '^[OR^n'   fzf-note
bindkey               '^[OQ'     del-or-fzfz # <ctrl-;> -> F2
bindkey               '^[ORa'    fzf-audio
bindkey               '^[ORv'    fzf-video
bindkey               '^[ORp'    fzf-pic
bindkey               '^r'       fzf-history
bindkey               '^s'       autopair
bindkey               '^t'       fzf-starstar
bindkey               '^u'       kill-whole-line
bindkey               '^y'       yank-buffer
bindkey               '^z'       fg-bg
bindkey               '^[[14~'   vi-forward-word # This key will trigger partial autocomplete
