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

alias rrlocal_railsrc='vim /Users/stamen/.local_railsrc'

alias rr='bundle exec rails'
alias rrr='bundle exec rake'
rrs(){
  if [ -f ./script/server ]; then
    ./script/server $@ # Rails < 3
  else
    bundle exec rails server thin $@
    #unicorn -d -p 3000
    #rails server $@ # Rails 3
  fi
}

rrsproduction(){
  if [ -f ./script/server ]; then
    ./script/server -e production $@
  else
    bundle exec rails server -e production $@
  fi
}

rrconsole(){
  if [ -f ./script/server ]; then
    ./script/console $@
  else
    rr c $@
  fi
}

rrgenerate(){
  if [ -f ./script/server ]; then
    ./script/generate $@
  else
    rr generate $@
  fi
}

alias rrrakelist='rrr -T | g ":"'
alias rrrakefind='rrr -T | g '
#alias rrake=rake
#complete -C ~/cl/bin/rr/rake-completion.rb -o default rake rrrake

rrtest(){
  rrr | highlight red " [1-9]0* failures" red " [1-9]0* errors"
}

rrtestsingle(){
  #rrr test:units TEST="$@" | awk -F"," '{printf("%20s%20s%20s%20s\n", $1,$2,$3,$4)}' | highlight red " [1-9]0* failures" red " [1-9]0* errors"
  rrr test:units TEST="$@" | highlight red " [1-9]0* failures" red " [1-9]0* errors"
}

rrtestsummary(){
  rrr | grep "tests," | awk -F"," '{printf("%20s%20s%20s%20s\n", $1,$2,$3,$4)}' | highlight red " [1-9]0* failures" red " [1-9]0* errors"
}

alias rrmigrate='rrr db:migrate'
rrmigratedown (){
  rrr db:migrate:down VERSION=$@
}
rrmigrateup (){
  rrr db:migrate:up VERSION=$@
}
alias rrmigratetest='rrr db:migrate RAILS_ENV="test"'
