# Rails and Rake -------------------------------------------------
alias rrshowcommands="echo -e '${COLOR_LIGHT_PURPLE}Available commands: 
   ${COLOR_BLUE}rr${COLOR_NC}server
   ${COLOR_BLUE}rr${COLOR_NC}server${COLOR_BLUE}production
   ${COLOR_BLUE}rr${COLOR_NC}generate
   ${COLOR_BLUE}rr${COLOR_NC}console
   ${COLOR_BLUE}rr${COLOR_NC}test
   ${COLOR_BLUE}rr${COLOR_NC}test${COLOR_BLUE}summary
   ${COLOR_BLUE}rr${COLOR_NC}rake${COLOR_BLUE}list
   ${COLOR_BLUE}rr${COLOR_NC}migrate
   ${COLOR_BLUE}rr${COLOR_NC}migrate${COLOR_BLUE}test
   ${COLOR_BLUE}rr${COLOR_NC}migrate${COLOR_BLUE}down
   ${COLOR_BLUE}rr${COLOR_NC}migrate${COLOR_BLUE}up
'"

alias rrserver='./script/server'
alias rrserverproduction='./script/server -e production'
alias rrgenerate='./script/generate'
alias rrconsole='./script/console'

alias rrrakelist='rake -T | g ":"'
alias rrrakefind='rake -T | g '
#alias rrake=rake
#complete -C ~/cl/bin/rr/rake-completion.rb -o default rake rrrake

rrtest(){
  date
  rake | highlight red " [1-9]0* failures" red " [1-9]0* errors"
  date
}

rrtestsingle(){
  rake test:units TEST="$@" | awk -F"," '{printf("%20s%20s%20s%20s\n", $1,$2,$3,$4)}' | highlight red " [1-9]0* failures" red " [1-9]0* errors"
}

rrtestsummary(){
  date
  rake | grep "tests," | awk -F"," '{printf("%20s%20s%20s%20s\n", $1,$2,$3,$4)}' | highlight red " [1-9]0* failures" red " [1-9]0* errors"
  date
}

alias rrmigrate='rake db:migrate'
rrmigratedown (){
  rake db:migrate:down VERSION=$@
}
rrmigrateup (){
  rake db:migrate:up VERSION=$@
}
alias rrmigratetest='rake db:migrate RAILS_ENV="test"'
