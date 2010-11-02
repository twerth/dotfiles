#!/usr/bin/env ruby

prefix = ARGV[1] 

words = `mysql --silent --skip-column-names -u ${MYSQL_DEFAULT_USER} -e "show databases"`.split.uniq
words = words.select {|w| /^#{Regexp.escape prefix}/ =~ w} if prefix

puts words
