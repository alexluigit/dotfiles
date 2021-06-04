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
