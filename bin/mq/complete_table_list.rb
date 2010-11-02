#!/usr/bin/env ruby

prefix = ARGV[1] 

tables = `mysql --silent --skip-column-names -u ${MYSQL_DEFAULT_USER} -D ${MYSQL_DEFAULT_DB} -e "show tables"`.split
tables = tables.select {|t| /^#{Regexp.escape prefix}/ =~ t} if prefix
puts tables
