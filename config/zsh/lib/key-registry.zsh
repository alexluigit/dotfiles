# See keylist at https://www.zsh.org/mla/users/2014/msg00266.html
zle -N ctrl-a;       bindkey    '^a'        ctrl-a
zle -N ctrl-b;       bindkey    '^b'        ctrl-b
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
zle -N ctrl-u;       bindkey    '^u'        ctrl-u
zle -N ctrl-xx;      bindkey    '^x^x'      ctrl-xx
zle -N ctrl-y;       bindkey    '^y'        ctrl-y
zle -N ctrl-z;       bindkey    '^z'        ctrl-z
zle -N ctrl-\;;      bindkey    '^[[14~'    ctrl-\; # <ctrl-;> -> F4
zle -N ctrl-RT;      bindkey    '^[[15~'    ctrl-RT # <ctrl-return> -> F5
zle -N backspace;    bindkey    '^?'        backspace
zle -N angle_pair;   bindkey    '<'         angle_pair
zle -N brace_pair;   bindkey    '('         brace_pair
zle -N brket_pair;   bindkey    '['         brket_pair
zle -N curly_pair;   bindkey    '{'         curly_pair
zle -N quote_pair;   bindkey    "'"         quote_pair
zle -N Quote_pair;   bindkey    '"'         Quote_pair
