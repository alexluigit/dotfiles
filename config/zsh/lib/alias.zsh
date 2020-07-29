# general
alias c="fzf-cd"
alias d="gio trash"
alias f="vifmrun ."
alias j="z"
alias jj="fzf-z"
alias t="tmux-automation"
alias v='nvim -c "let g:tty='\''$(tty)'\''"'
alias ka="killall"
alias md="mkdir -p"
alias sv="sudoedit"
alias yd="youtube-dl --write-sub --write-auto-sub -o '~/Desktop/%(title)s-%(id)s.%(ext)s'"
alias ydl="youtube-dl --yes-playlist --write-sub --write-auto-sub -o '~/Desktop/%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s'"
alias ls="ls --group-directories-first --color=auto"
alias la='ls -lAFh'   #long list,show almost all,show type,human readable
alias ldot='ls -ld .*'
alias lsize='ls -1FSsh'
alias lart='ls -1aFcrt'
alias -g B="| bat"
alias -g F="| fzf" alias -g G="| rg"
alias -g NE="2> /dev/null"
alias -g NUL="> /dev/null 2>&1"
alias -g S="| sort -n -r"
alias -g W="| wc -l"

# git
alias gap="git add -p"
alias gab="git abv"
alias gaa="git commit --amend -v" # amend both msg and commit
alias gaf="git commit --amend --no-edit" # amend just commit
alias gam="git commit --amend --only -v --" #amend just msg
alias gco="git checkout"
alias gcm="git checkout master"
alias gcv="git commit -v"
alias get="git remote update --prune && git merge --ff-only" # updating all remotes and fast-forwarding to a specific one: eg. `git get upstream/master`
alias gfu="git fixup"
alias ghd="GIT_NO_PAGER=1 git loghelpers pretty_git_log -1" # just head
alias gnb="git checkout -b" # new branch
alias grw="git rewind"
alias gss="git status -s"
alias gst="git stash --keep-index" # stsh
alias gsa="git stash --include-untracked" # staash
alias gup="git loghelpers pretty_git_log --all origin/master..master" # unpushed
alias gbo="git loghelpers pretty_git_graph --all --simplify-by-decoration" # bone
alias gcp="git cherry-pick"
alias gct="git --no-pager log --oneline | wc -l" #count
alias gdp="git ls-tree -r HEAD | cut -c 13- | sort | uniq -D -w 40" # http://stackoverflow.com/questions/224687/git-find-duplicate-blobs-files-in-this-tree/8408640#8408640
alias gff="git merge --ff-only"
alias gfr="git remote update --prune"
alias glp="git loghelpers pretty_git_log --all" # log grep, in case forgit::log omit something
alias gra="git loghelpers pretty_git_graph --all"
alias gre="GIT_NO_PAGER=1 git loghelpers pretty_git_log --all -30" # recent
alias gwd="git --paginate diff --dirstat=cumulative,files,0"

# pacman
alias pas="fzf-pac-sync"
alias pal="fzf-pac-local"
alias pacupg="sudo pacman -Syu"
alias pacaur="pacman -Qm"
alias pacorp="pacman -Qdt"
alias pacrmo="sudo pacman -Rns $(pacman -Qtdq)" # remove orphan
