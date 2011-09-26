if type -P mysql &>/dev/null ; then # This script only works if you have 'mysql' installed

  # Currently, this only works with a local mysql without a password (my dev environment)

  alias mqshowcommands="echo -e '${COLOR_LIGHT_PURPLE}Available commands: 
     ${COLOR_BLUE}mq${COLOR_NC}databases${COLOR_NC}
     ${COLOR_BLUE}mq${COLOR_NC}use${COLOR_BLUE}database${COLOR_NC}
     ${COLOR_BLUE}mq${COLOR_NC}create${COLOR_BLUE}database${COLOR_NC}
     ${COLOR_BLUE}mq${COLOR_NC}drop${COLOR_BLUE}database${COLOR_NC}
     ${COLOR_BLUE}mq${COLOR_NC}tables${COLOR_NC}
     ${COLOR_BLUE}mq${COLOR_NC}fields${COLOR_NC}
     ${COLOR_BLUE}mq${COLOR_NC}run              ${COLOR_GRAY}Example: mqrun \"Select id From foo\"
     ${COLOR_BLUE}mq${COLOR_NC}run${COLOR_BLUE}to${COLOR_NC}html${COLOR_NC}        ${COLOR_GRAY}OSX only
     ${COLOR_BLUE}mq${COLOR_NC}file${COLOR_BLUE}run${COLOR_NC}          ${COLOR_GRAY}Example: mqfilerun file_name
     ${COLOR_BLUE}mq${COLOR_NC}file${COLOR_BLUE}run${COLOR_NC}to${COLOR_BLUE}file${COLOR_NC}    ${COLOR_GRAY}Example: mqrunfiletofile file_name out_file_name
     ${COLOR_BLUE}mq${COLOR_NC}file${COLOR_BLUE}run${COLOR_NC}to${COLOR_BLUE}editor${COLOR_NC}
     ${COLOR_BLUE}mq${COLOR_NC}all${COLOR_NC}
     ${COLOR_BLUE}mq${COLOR_NC}all${COLOR_BLUE}count${COLOR_NC}
     ${COLOR_BLUE}mq${COLOR_NC}all${COLOR_BLUE}grep${COLOR_NC}
     ${COLOR_BLUE}mq${COLOR_NC}all${COLOR_BLUE}to${COLOR_NC}html${COLOR_NC}        ${COLOR_GRAY}OSX only
  '"

  if [ "${MYSQL_DEFAULT_DB}" == "" ] ; then
    export MYSQL_DEFAULT_DB=mysql
    export MYSQL_DEFAULT_USER=root
  fi

  mqusedatabase (){
    export MYSQL_DEFAULT_DB=$@
    mqrun  "show tables"
  }

  mqrun (){
    mysql -u ${MYSQL_DEFAULT_USER} -t -D ${MYSQL_DEFAULT_DB} -vvv -e "$@" | highlight blue '[|+-]'
  }
  mqfilerun (){
    mysql -u ${MYSQL_DEFAULT_USER} -t -vvv ${MYSQL_DEFAULT_DB} < $@ | highlight blue '[|+-]'
  }
  mqfileruntofile (){
    mysql -u ${MYSQL_DEFAULT_USER} -t -vvv ${MYSQL_DEFAULT_DB} < $1 >> $2
  }
  mqrunfiletoeditor (){
    mysql -u ${MYSQL_DEFAULT_USER} -t -vvv ${MYSQL_DEFAULT_DB} < $1 | vim - 
  }
  mqscriptrun (){
    mysql --silent --skip-column-names -u ${MYSQL_DEFAULT_USER} -D ${MYSQL_DEFAULT_DB} -e "$@"
  }

  if [ "$OS" = "darwin" ] ; then # OS X only
    mqruntohtml (){
      rm /tmp/query.html
      mysql -H -u ${MYSQL_DEFAULT_USER} -D ${MYSQL_DEFAULT_DB} -t -vvv  -e "$@" | erb ~/cl/bin/mq/table_template.html.erb >> /tmp/query.html
      open /tmp/query.html
    }
    mqalltohtml (){
      rm /tmp/query.html
      mysql -H -u ${MYSQL_DEFAULT_USER} -D ${MYSQL_DEFAULT_DB} -t -vvv -e "select * from $@" | erb ~/cl/bin/mq/table_template.html.erb >> /tmp/query.html
      open /tmp/query.html
    }
  fi

  mqall (){
    mysql -u ${MYSQL_DEFAULT_USER} -t -D ${MYSQL_DEFAULT_DB} -vvv -e "select * from $@" | highlight blue '[|+-]'
  }
  mqallcount (){
    mysql -u ${MYSQL_DEFAULT_USER} -t -D ${MYSQL_DEFAULT_DB} -vvv -e "select count(*) from $@" | highlight blue '[|+-]'
  }
  mqallgrep (){
    mysql -u ${MYSQL_DEFAULT_USER} -t -D ${MYSQL_DEFAULT_DB} -vvv -e "select * from $1" | g "($2)"
  }
  mqfirst (){
    if [[ "$2" == "" ]]; then
      mysql -u ${MYSQL_DEFAULT_USER} -t -D ${MYSQL_DEFAULT_DB} -vvv -e "select * from $1 limit 1" | highlight blue '[|+-]'
    else
      mysql -u ${MYSQL_DEFAULT_USER} -t -D ${MYSQL_DEFAULT_DB} -vvv -e "select * from $1 limit $2" | highlight blue '[|+-]'
    fi
  }
  mqallwhere (){
    mysql -u ${MYSQL_DEFAULT_USER} -t -D ${MYSQL_DEFAULT_DB} -vvv -e "select * from $1 where $2"
  }

  mqdatabases (){
    mqrun "show databases"
    echo -e "\nCurrent DB: ${MYSQL_DEFAULT_DB}"
  }

  alias mqtables='mqrun "show tables"' 

  mqfields(){
    mqrun "describe $@"
  }

  mqcreatedatabase(){
    mysqladmin -u ${MYSQL_DEFAULT_USER} create $@
    echo "$@ Created" | highlight blue '.*'
  }

  mqdropdatabase(){
    echo Warning | highlight red '.*'
    mysqladmin -u ${MYSQL_DEFAULT_USER} drop $@ 
  }

  # Completion
  complete -o nospace -C ~/cl/bin/mq/complete_database_list.rb mqusedatabase mqdropdatabase
  complete -o default -C ~/cl/bin/mq/complete_table_list.rb mqall mqallcount mqallgrep mqfirst mqfields mqalltohtml mqallwhere

fi
