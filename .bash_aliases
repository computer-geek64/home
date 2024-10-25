alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias branch='git checkout `git branch --format="%(refname:short)" | fzf --info-command="git log --oneline -1 {}" --preview="git diff --stat ..{}" --height=20`'

alias sandbox='docker run -it --rm --network=host -v /var/run/docker.sock:/var/run/docker.sock -v /etc/localtime:/etc/localtime:ro sandbox:latest'


function search() {
    grep -irlP "$@" | fzf --info-command="grep -icP $1 {}" --preview="grep -inP $1 {}" --height=20
}
