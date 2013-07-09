# git ------------------------------------------------
alias gtshowcommands="echo -e '${COLOR_LIGHT_PURPLE}Available commands: 
   ${COLOR_BLUE}gt
   ${COLOR_BLUE}gt${COLOR_NC}init
   ${COLOR_BLUE}gt${COLOR_NC}commit    ${COLOR_GRAY}Example: gtcommit \"Your message here\"
   ${COLOR_BLUE}gt${COLOR_NC}commit${COLOR_BLUE}all${COLOR_NC}    ${COLOR_GRAY}Example: gtcommitall \"Your message here\"
   ${COLOR_BLUE}gt${COLOR_NC}add       ${COLOR_GRAY}Example: gtadd your_file
   ${COLOR_BLUE}gt${COLOR_NC}add${COLOR_BLUE}all${COLOR_NC}    ${COLOR_GRAY}Note: adds all files not in repository [recursively]
   ${COLOR_BLUE}gt${COLOR_NC}show
   ${COLOR_BLUE}gt${COLOR_NC}grep
   ${COLOR_BLUE}gt${COLOR_NC}diff
   ${COLOR_BLUE}gt${COLOR_NC}diff${COLOR_BLUE}staged${COLOR_NC}
   ${COLOR_BLUE}gt${COLOR_NC}merge
   ${COLOR_BLUE}gt${COLOR_NC}merge${COLOR_BLUE}head${COLOR_NC}
   ${COLOR_BLUE}gt${COLOR_NC}merge${COLOR_BLUE}with${COLOR_NC}tool
   ${COLOR_BLUE}gt${COLOR_NC}push
   ${COLOR_BLUE}gt${COLOR_NC}pull
   ${COLOR_BLUE}gt${COLOR_NC}fetch
   ${COLOR_BLUE}gt${COLOR_NC}checkout  ${COLOR_GRAY}(switch branch or revert) Example: gtcheckout your_file or gtcheckout your_local_branch  
   ${COLOR_BLUE}gt${COLOR_NC}checkout${COLOR_BLUE}tracking${COLOR_NC}branch${COLOR_NC}  ${COLOR_GRAY}Example: gtcheckouttrackingbranch your_branch  
   ${COLOR_BLUE}gt${COLOR_NC}blame
   ${COLOR_BLUE}gt${COLOR_NC}log
   ${COLOR_BLUE}gt${COLOR_NC}log${COLOR_BLUE}short${COLOR_NC}
   ${COLOR_BLUE}gt${COLOR_NC}log${COLOR_BLUE}graph${COLOR_NC}
   ${COLOR_BLUE}gt${COLOR_NC}log${COLOR_BLUE}grep${COLOR_NC}
   ${COLOR_BLUE}gt${COLOR_NC}log${COLOR_BLUE}for${COLOR_NC}user
   ${COLOR_BLUE}gt${COLOR_NC}branch
   ${COLOR_BLUE}gt${COLOR_NC}branch${COLOR_BLUE}delete${COLOR_NC}
   ${COLOR_BLUE}gt${COLOR_NC}branch${COLOR_BLUE}list${COLOR_NC}all
   ${COLOR_BLUE}gt${COLOR_NC}status
   ${COLOR_BLUE}gt${COLOR_NC}stash
   ${COLOR_BLUE}gt${COLOR_NC}stash${COLOR_BLUE}save${COLOR_NC}
   ${COLOR_BLUE}gt${COLOR_NC}stash${COLOR_BLUE}list${COLOR_NC}
   ${COLOR_BLUE}gt${COLOR_NC}stash${COLOR_BLUE}apply${COLOR_NC}
   ${COLOR_BLUE}gt${COLOR_NC}move${COLOR_BLUE}last${COLOR_NC}committostaged
'"

alias gt='git'
alias gtinit='gt init'
alias gtclone='gt clone'
alias gtadd='gt add'
alias gtaddall='gt add .'
alias gtdiff='gt diff'
alias gtdiffstaged='gt diff --cached'
alias gtpush='gt push'
alias gtfetch='gt fetch'
alias gthelp='gt help'
alias gtpull='gt pull'
alias gtpullrebase='gt pull --rebase'
alias gtdelete='gt rm'
#alias gtdeleteall='git status | grep "^\!" | awk "{print \$2}" | xargs svn delete'
#alias gtdeleteall='gt rm'
alias gtmove='gt mv'
alias gtshow='gt show'
alias gtblame='gt blame'
alias gtstatus='gt status'
alias gtmerge='gt merge'
alias gtmergehead='gt merge origin/master'
alias gtmergewithtool='gt mergetool'
alias gttagadd='gt tag -a'
alias gttaglist='gt tag -l'
alias gtbranch='gt branch'
alias gtbranchdelete='gt branch -d'
alias gtbranchlistall='gt branch -a'
alias gtstash='gt stash'
alias gtstashsave='gt stash save'
alias gtstashlist='gt stash list'
alias gtstashapply='gt stash apply'
alias gtmovelastcommittostaged='gt reset --soft HEAD^'
alias gtbranchesmerged='git branch -a --merged'
alias gtbranchesnomerged='git branch -a --no-merged'
alias gtresethardandclean='git reset --hard && git clean -fdx'

gtcommit(){
  gt commit -m "$@"
}

gtcommitall(){
  gt commit -a -v -m "$@"
}

gtpushorigin(){
  gt push origin $@
}

gtcheckout (){
  gt checkout $1
}
gtcheckouttrackingbranch (){
  gt checkout -tlb $1 origin/$1
}

alias gtlog='gt log --name-status'
alias gtlogshort='gt log --pretty=oneline'
alias gtloggraph='gt log --graph'
gtlogforuser(){
  gtlog --author=$1
}
gtloggrep(){
  gtlog | grep $@ -B20 -A20
}

gtgrep(){
  gt grep -n --ignore-case -e "$@" | highlight green "$@" blue "^.*\:"
}

gtswitchtomaster (){
  git checkout master
  git pull
}

gtcreateremotebranch (){
  git checkout -b $1
  git push -u origin $1 
}

complete -C ~/cl/bin/gt/complete_branch_list.rb -o default gtcheckout gtpushorigin
