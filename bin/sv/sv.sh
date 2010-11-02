# Subversion & Diff ------------------------------------------------
export SVN_EDITOR='${EDITOR}'
alias svshowcommands="echo -e '${COLOR_LIGHT_PURPLE}Available commands:
   ${COLOR_BLUE}sv
   ${COLOR_BLUE}sv${COLOR_NC}help
   ${COLOR_BLUE}sv${COLOR_NC}import    ${COLOR_GRAY}Example: import ~/projects/my_local_folder http://svn.foo.com/bar
   ${COLOR_BLUE}sv${COLOR_NC}checkout  ${COLOR_GRAY}Example: svcheckout http://svn.foo.com/bar
   ${COLOR_BLUE}sv${COLOR_NC}status
   ${COLOR_BLUE}sv${COLOR_NC}status${COLOR_BLUE}remote
   ${COLOR_BLUE}sv${COLOR_NC}add       ${COLOR_GRAY}Example: svadd your_file
   ${COLOR_BLUE}sv${COLOR_NC}add${COLOR_BLUE}all${COLOR_NC}    ${COLOR_GRAY}Note: adds all files not in repository [recursively]
   ${COLOR_BLUE}sv${COLOR_NC}delete    ${COLOR_GRAY}Example: svdelete your_file
   ${COLOR_BLUE}sv${COLOR_NC}diff      ${COLOR_GRAY}Example: svdiff your_file
   ${COLOR_BLUE}sv${COLOR_NC}diff${COLOR_BLUE}remote${COLOR_NC}   ${COLOR_GRAY}Example: svdiffremote your_file
   ${COLOR_BLUE}sv${COLOR_NC}commit    ${COLOR_GRAY}Example: svcommit
   ${COLOR_BLUE}sv${COLOR_NC}update    ${COLOR_GRAY}Example: svupdate
   ${COLOR_BLUE}sv${COLOR_NC}get${COLOR_BLUE}info${COLOR_NC}   ${COLOR_GRAY}Example: svgetinfo your_file
   ${COLOR_BLUE}sv${COLOR_NC}blame     ${COLOR_GRAY}Example: svblame your_file
   ${COLOR_BLUE}sv${COLOR_NC}delete${COLOR_BLUE}svn${COLOR_NC}folders   ${COLOR_GRAY}Example: svdeletesvnfolders
'"

alias sv='svn'
alias svimport='sv import'
alias svcheckout='sv checkout'
alias svstatusremote='sv status --show-updates' # Show status here and on the server
alias svcommit='sv commit'
alias svadd='sv add'
alias svaddall='sv status | grep "^\?" | awk "{print \$2}" | xargs svn add'
alias svdelete='sv delete'
alias svhelp='sv help' 
alias svblame='sv blame'
alias svdeletesvnfolders='find . -name ".svn" -exec rm -rf {} \;'
alias svexcludeswpfiles='sv propset svn:ignore "*.swp" .' 
alias svdeleteall='sv status | grep "^\!" | awk "{print \$2}" | xargs svn delete'

svupdate (){
  sv update | highlight red "C .*" green "G .*" blue "A .*" yellow "D .*"
}

svstatus (){
  sv status | highlight red "D .*" green "\? .*" blue "A .*"
}

svgetinfo (){
  sv info $@
  sv log $@
}

if [ "$OS" = "darwin" ] ; then
  # You need to create fmdiff and fmresolve, which can be found at: http://ssel.vub.ac.be/ssel/internal:fmdiff
  alias svdiff='sv diff --diff-cmd fmdiff' # OS-X SPECIFIC
  alias svdiffremote='sv diff -r HEAD --diff-cmd fmdiff' # OS-X SPECIFIC
  # Use diff for command line diff, use fmdiff for gui diff, and svdiff for subversion diff
fi
