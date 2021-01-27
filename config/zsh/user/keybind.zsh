ctrl-a()  { zle beginning-of-line; }
ctrl-f()  { _lf; }
ctrl-j()  {}
ctrl-r()  { _fzf_hist; }
ctrl-s()  {}
ctrl-xx() { _fzf_kill; }
ctrl-y()  { _yank_cmdline; }
ctrl-p()  { _fzf_navi z; }
ctrl-t()  { _fzf_comp_helper; }
ctrl-u()  { zle kill-whole-line; }
ctrl-b()  {}
ctrl-k()  { zle edit-command-line; }
ctrl-RT() { [[ $#LBUFFER -ne $#BUFFER ]] && zle end-of-line || zle autosuggest-accept; }
ctrl-i()  { [[ -n $BUFFER ]] && zle backward-char || fmenu false . "Edit: " nvim; }
ctrl-o()  { [[ -n $BUFFER ]] && zle forward-char || fmenu; }
ctrl-d()  { [[ -n $BUFFER ]] && zle delete-char || _fzf_cd; }
ctrl-h()  { [[ -n $BUFFER ]] && zle backward-delete-char || _updir; }
ctrl-l()  { [[ -n $BUFFER ]] && zle vi-backward-word || zle clear-screen; }
ctrl-\;() { [[ -n $BUFFER ]] && zle vi-forward-word || _fzf_navi home; }
ctrl-z()  { [[ -n $BUFFER ]] && zle push-input || _resume_jobs; }
