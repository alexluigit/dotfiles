typeset -gA AUTOPAIR_PAIRS=('`' '`' "'" "'" '"' '"' '{' '}' '[' ']' '(' ')' '<' '>' ' ' ' ')
__autopairs() {
  local pair
  [ $1 == 'a' ] && pair='<'
  [ $1 == 'b' ] && pair='('
  [ $1 == 'r' ] && pair='['
  [ $1 == 'c' ] && pair='{'
  [ $1 == 'q' ] && pair="'"
  [ $1 == 'Q' ] && pair='"'
  RBUFFER=$pair$AUTOPAIR_PAIRS[$pair]$RBUFFER
  zle forward-char
}

backspace() { zle backward-delete-char }
angle_pair() { __autopairs a; }
brace_pair() { __autopairs b; }
brket_pair() { __autopairs r; }
curly_pair() { __autopairs c; }
quote_pair() { __autopairs q; }
Quote_pair() { __autopairs Q; }
