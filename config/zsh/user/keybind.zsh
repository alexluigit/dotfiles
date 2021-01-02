ctrl-a() { zle beginning-of-line; }
ctrl-f() { __lf; }
ctrl-j() { __todolist; }
ctrl-r() { __fzf-hist; }
ctrl-s() {}
ctrl-xx(){ __fzf-kill; }
ctrl-y() { __yank-cmdline; }
ctrl-p(){ __fzf-navi z; }
ctrl-t() { __fzf-comp-helper; }
ctrl-u() { zle kill-whole-line; }
ctrl-b() { zbug; }
ctrl-k() { zle edit-command-line; }
ctrl-\'(){ [[ $#LBUFFER -ne $#BUFFER ]] && zle end-of-line || zle autosuggest-accept; }
ctrl-RT(){ [[ -n $BUFFER ]] && zle accept-line || __quick-sudo; }
ctrl-i() { [[ -n $BUFFER ]] && zle backward-char || __fzf-open . "Edit: " nvim; }
ctrl-o() { [[ -n $BUFFER ]] && zle forward-char || __fzf-open-menu; }
ctrl-d() { [[ -n $BUFFER ]] && zle delete-char || __fzf-cd; }
ctrl-h() { [[ -n $BUFFER ]] && zle backward-delete-char || __updir; }
ctrl-l() { [[ -n $BUFFER ]] && zle vi-backward-word || zle clear-screen; }
ctrl-\;(){ [[ -n $BUFFER ]] && zle vi-forward-word || __fzf-navi home; }
ctrl-z() { [[ -n $BUFFER ]] && zle push-input || __resume-jobs; }
