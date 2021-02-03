ctrl-a()  { zle beginning-of-line; }
ctrl-b()  {}
ctrl-d()  { [[ -n $BUFFER ]] && zle delete-char || _fzf_cd; }
ctrl-e()  { zle up-line-or-beginning-search; }
ctrl-f()  { _lf; }
ctrl-h()  { [[ -n $BUFFER ]] && zle backward-delete-char || _updir; }
ctrl-i()  { [[ -n $BUFFER ]] && zle backward-char || fmenu 0 . "Edit: " nvim; }
ctrl-k()  { zle edit-command-line; }
ctrl-l()  { [[ -n $BUFFER ]] && zle vi-backward-word || zle clear-screen; }
ctrl-n()  { zle down-line-or-beginning-search; }
ctrl-o()  { [[ -n $BUFFER ]] && zle forward-char || fmenu; }
ctrl-p()  { _fzf_navi z; }
ctrl-r()  { _fzf_hist; }
ctrl-s()  {}
ctrl-t()  { _fzf_comp_helper; }
ctrl-u()  { zle kill-whole-line; }
ctrl-xx() { _fzf_kill; }
ctrl-y()  { _yank_cmdline; }
ctrl-z()  { [[ -n $BUFFER ]] && zle push-input || _resume_jobs; }
ctrl-return()  { [[ $#LBUFFER -ne $#BUFFER ]] && zle end-of-line || zle autosuggest-accept; }
ctrl-semi()    { [[ -n $BUFFER ]] && zle vi-forward-word || _fzf_navi home; }
backspace()    { zle backward-delete-char; }
open-angle()   { _autopairs a; }
open-brace()   { _autopairs b; }
open-brket()   { _autopairs r; }
open-curly()   { _autopairs c; }
single-quote() { _autopairs q; }
double-quote() { _autopairs Q; }
