ctrl-a() { zle beginning-of-line; }
ctrl-f() { _lf; }
ctrl-j() { _todolist; }
ctrl-r() { _fzf_hist; }
ctrl-s() {}
ctrl-xx(){ _fzf_kill; }
ctrl-y() { _yank_cmdline; }
ctrl-p(){ _fzf_navi z; }
ctrl-t() { _fzf_comp_helper; }
ctrl-u() { zle kill-whole-line; }
ctrl-b() { zbug; }
ctrl-k() { zle edit-command-line; }
ctrl-\'(){ [[ $#LBUFFER -ne $#BUFFER ]] && zle end-of-line || zle autosuggest-accept; }
ctrl-RT(){ [[ -n $BUFFER ]] && zle accept-line || _quick-sudo; }
ctrl-i() { [[ -n $BUFFER ]] && zle backward-char || _fzf_open . "Edit: " nvim; }
ctrl-o() { [[ -n $BUFFER ]] && zle forward-char || _fzf_open_menu; }
ctrl-d() { [[ -n $BUFFER ]] && zle delete-char || _fzf_cd; }
ctrl-h() { [[ -n $BUFFER ]] && zle backward-delete-char || _updir; }
ctrl-l() { [[ -n $BUFFER ]] && zle vi-backward-word || zle clear-screen; }
ctrl-\;(){ [[ -n $BUFFER ]] && zle vi-forward-word || _fzf_navi home; }
ctrl-z() { [[ -n $BUFFER ]] && zle push-input || _resume_jobs; }
