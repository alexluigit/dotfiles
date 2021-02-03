# See keylist at https://www.zsh.org/mla/users/2014/msg00266.html
stty -ixon # Disable XON/XOFF flow control
autoload -Uz up-line-or-beginning-search; zle -N up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search; zle -N down-line-or-beginning-search
autoload -Uz edit-command-line; zle -N edit-command-line
local c_keys=(a b d e f h k l n o p r s t u y z)
for key in ${c_keys[@]}; do zle -N ctrl-$key; bindkey ^$key ctrl-$key; done
zle -N ctrl-i;       bindkey    '^[[17~'    ctrl-i
zle -N ctrl-xx;      bindkey    '^x^x'      ctrl-xx
zle -N ctrl-return;  bindkey    '^[[15~'    ctrl-return # <ctrl-return> -> F5
zle -N ctrl-semi;    bindkey    '^[[14~'    ctrl-semi # <ctrl-;> -> F4
zle -N backspace;    bindkey    '^?'        backspace
zle -N open-angle;   bindkey    '<'         open-angle
zle -N open-brace;   bindkey    '('         open-brace
zle -N open-brket;   bindkey    '['         open-brket
zle -N open-curly;   bindkey    '{'         open-curly
zle -N single-quote; bindkey    "'"         single-quote
zle -N double-quote; bindkey    '"'         double-quote

# Vi-mode
autoload -Uz move-line-in-buffer
autoload -Uz select-quoted select-bracketed
autoload -Uz surround
zle -N select-quoted; zle -N select-bracketed
zle -N delete-surround surround; zle -N add-surround surround; zle -N change-surround surround
zle -N up-line-in-buffer move-line-in-buffer; zle -N down-line-in-buffer move-line-in-buffer
for m in visual viopp; do
  for c in {a,i}{\',\",\`}; do; bindkey -M $m $c select-quoted; done
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do; bindkey -M $m $c select-bracketed; done
done
bindkey -v
bindkey -a            'cs'          change-surround
bindkey -a            'ds'          delete-surround
bindkey -a            'ys'          add-surround
bindkey -a            \'            vi-forward-char
bindkey -M vicmd      'e'           up-line-in-buffer # Do not go search history
bindkey -M vicmd      'n'           down-line-in-buffer
bindkey -M visual     'S'           add-surround
bindkey -M menuselect 'h'           vi-backward-char
bindkey -M menuselect 'e'           vi-up-line-or-history
bindkey -M menuselect  \'           vi-forward-char
bindkey -M menuselect 'n'           vi-down-line-or-history
