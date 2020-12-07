inside-worktree() { git rev-parse --is-inside-work-tree >/dev/null 2>&1; }
gitpager=$(git config core.pager || echo 'cat')

# git commit viewer
fzf-git-log() {
    inside-worktree || return 1
    local cmd opts graph files
    files=$(sed -nE 's/.* -- (.*)/\1/p' <<< "$*") # extract files parameters for `git show` command
    cmd="echo {} |grep -Eo '[a-f0-9]+' |head -1 |xargs -I% git show --color=always % -- $files | $gitpager"
    opts="
        $FORGIT_FZF_DEFAULT_OPTS
        +s +m --tiebreak=index
        --bind=\"enter:execute($cmd | LESS='-R' less)\"
        --bind=\"ctrl-y:execute-silent(echo {} |grep -Eo '[a-f0-9]+' | head -1 | tr -d '\n' |${FORGIT_COPY_CMD:-pbcopy})\"
    "
    eval "git log --graph --color=always --format='%C(auto)%h%d %s %C(black)%C(bold)%cr' $*" |
        FZF_DEFAULT_OPTS="$opts" fzf --preview="$cmd"
}

# git diff viewer
fzf-git-diff() {
    inside-worktree || return 1
    local cmd files opts commit repo
    [[ $# -ne 0 ]] && {
        if git rev-parse "$1" -- &>/dev/null ; then
            commit="$1" && files=("${@:2}")
        else
            files=("$@")
        fi
    }
    repo="$(git rev-parse --show-toplevel)"
    cmd="echo {} |sed 's/.*]  //' |xargs -I% git diff --color=always $commit -- '$repo/%' |$gitpager"
    opts="
        $FORGIT_FZF_DEFAULT_OPTS
        +m -0 --bind=\"enter:execute($cmd |LESS='-R' less)\"
    "
    eval "git diff --name-status $commit -- ${files[*]} | sed -E 's/^(.)[[:space:]]+(.*)$/[\1]  \2/'" |
        FZF_DEFAULT_OPTS="$opts" fzf --preview="$cmd"
}

# git stash viewer
fzf-git-stash() {
    inside-worktree || return 1
    local cmd opts
    cmd="echo {} |cut -d: -f1 |xargs -I% git stash show --color=always --ext-diff % |$gitpager"
    opts="
        $FORGIT_FZF_DEFAULT_OPTS
        +s +m -0 --tiebreak=index --bind=\"enter:execute($cmd | LESS='-R' less)\"
    "
    git stash list | FZF_DEFAULT_OPTS="$opts" fzf --preview="$cmd"
}

fzf-ignore() {
  # Todo
}

FORGIT_FZF_DEFAULT_OPTS="
$FZF_DEFAULT_OPTS
--ansi
--height='80%'
--bind='alt-k:preview-up,alt-e:preview-down'
--bind='alt-j:preview-down,alt-n:preview-down'
--bind='ctrl-r:toggle-all'
--bind='?:toggle-preview'
--bind='alt-w:toggle-preview-wrap'
--preview-window='right:60%'
+1
"

fzf-git-branch() {
  local tags branches target
  branches=$(
    git --no-pager branch --all \
      --format="%(if)%(HEAD)%(then)%(else)%(if:equals=HEAD)%(refname:strip=3)%(then)%(else)%1B[0;34;1mbranch%09%1B[m%(refname:short)%(end)%(end)" \
    | sed '/^$/d') || return
  tags=$(
    git --no-pager tag | awk '{print "\x1b[35;1mtag\x1b[m\t" $1}') || return
  target=$(
    (echo "$branches"; echo "$tags") |
    fzf --ansi --no-hscroll --no-multi -n 2 \
    --preview="git --no-pager log -150 --pretty=format:%s '..{2}'") || return
  git checkout $(awk '{print $2}' <<<"$target" )
}
