# See keylist at https://www.zsh.org/mla/users/2014/msg00266.html
                     bindkey    '^a'        beginning-of-line
zle -N ctrl-d;       bindkey    '^d'        ctrl-d
zle -N ctrl-f;       bindkey    '^f'        ctrl-f
zle -N ctrl-h;       bindkey    '^h'        ctrl-h
zle -N ctrl-i;       bindkey    '^[[17~'    ctrl-i
zle -N ctrl-j;       bindkey    '^j'        ctrl-j
zle -N ctrl-k;       bindkey    '^k'        ctrl-k
zle -N ctrl-l;       bindkey    '^l'        ctrl-l
zle -N ctrl-o;       bindkey    '^o'        ctrl-o
zle -N ctrl-p;       bindkey    '^p'        ctrl-p
zle -N ctrl-r;       bindkey    '^r'        ctrl-r
zle -N ctrl-s;       bindkey    '^s'        ctrl-s
zle -N ctrl-t;       bindkey    '^t'        ctrl-t
                     bindkey    '^u'        kill-whole-line
zle -N ctrl-xx;      bindkey    '^x^x'      ctrl-xx
zle -N ctrl-y;       bindkey    '^y'        ctrl-y
zle -N ctrl-z;       bindkey    '^z'        ctrl-z
zle -N ctrl-\;;      bindkey    '^[OQ'      ctrl-\; # <ctrl-;> -> F2
zle -N ctrl-\';      bindkey    '^[OR'      ctrl-\' # <ctrl-'> -> F3
zle -N ctrl-RT;      bindkey    '^[[14~'    ctrl-RT # <ctrl-return> -> F4
zle -N backspace;    bindkey    '^?'        backspace
zle -N ctrl-tn;      bindkey    '^t^n'      ctrl-tn
zle -N ctrl-te;      bindkey    '^t^e'      ctrl-te
zle -N ctrl-ti;      bindkey    '^t^[[17~'  ctrl-ti
zle -N ctrl-to;      bindkey    '^t^o'      ctrl-to
zle -N ctrl-tt;      bindkey    '^t^t'      ctrl-tt
zle -N zbug;         bindkey    '^b'        zbug   # for zle debug
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS+=(ctrl-\')
ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=(ctrl-l)
