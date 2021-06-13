# See keylist at https://github.com/prompt-toolkit/python-prompt-toolkit/blob/master/prompt_toolkit/input/ansi_escape_sequences.py
stty -ixon # Disable XON/XOFF flow control
autoload -Uz up-line-or-beginning-search; zle -N up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search; zle -N down-line-or-beginning-search
autoload -Uz edit-command-line; zle -N edit-command-line
local c_keys=(a b d e f k l n o p r s t u y z)
for key in ${c_keys[@]}; do zle -N ctrl-$key; bindkey ^$key ctrl-$key; done
bindkey -M menuselect 'n'                   vi-down-line-or-history
bindkey -M menuselect 'p'                   vi-up-line-or-history
zle -N ctrl-return;  bindkey    '^[[15~'    ctrl-return # <ctrl-return> -> F5
zle -N ctrl-i;       bindkey    '^[[17~'    ctrl-i      # <ctrl-i>      -> F6
zle -N ctrl-bslash;  bindkey    '^\\'       ctrl-bslash
zle -N backspace;    bindkey    '^?'        backspace
zle -N open-angle;   bindkey    '<'         open-angle
zle -N open-brace;   bindkey    '('         open-brace
zle -N open-brket;   bindkey    '['         open-brket
zle -N open-curly;   bindkey    '{'         open-curly
zle -N single-quote; bindkey    "'"         single-quote
zle -N double-quote; bindkey    '"'         double-quote

ctrl-a()  { zle beginning-of-line; }
ctrl-b()  { zle edit-command-line; }
ctrl-d()  { [[ -n $BUFFER ]] && zle delete-char || _fzf_cd; }
ctrl-e()  { zle end-of-line; }
ctrl-f()  { _lf; }
ctrl-i()  { [[ -n $BUFFER ]] && zle backward-char || f . "Edit: " nvim; }
ctrl-k()  { _fzf_kill; }
ctrl-l()  { [[ -n $BUFFER ]] && zle vi-backward-word || zle clear-screen; }
ctrl-n()  { zle down-line-or-beginning-search; }
ctrl-o()  { [[ -n $BUFFER ]] && zle forward-char || f; }
ctrl-p()  { zle up-line-or-beginning-search; }
ctrl-r()  { _fzf_hist; }
ctrl-s()  { f nav z; }
ctrl-t()  { _fzf_comp_helper; }
ctrl-u()  { [[ -n $BUFFER ]] && zle kill-whole-line || _updir; }
ctrl-y()  { _yank_cmdline; }
ctrl-z()  { [[ -n $BUFFER ]] && zle push-input || _resume_jobs; }
ctrl-bslash()  { [[ -n $BUFFER ]] && zle vi-forward-word || f nav home; }
ctrl-return()  { zle autosuggest-accept; }
backspace()    { zle backward-delete-char; }
open-angle()   { _autopairs a; }
open-brace()   { _autopairs b; }
open-brket()   { _autopairs r; }
open-curly()   { _autopairs c; }
single-quote() { _autopairs q; }
double-quote() { _autopairs Q; }
