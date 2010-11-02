#!/usr/bin/env ruby

prefix = ARGV[1] 

words = `git branch`.split.uniq
words = words.select {|w| /^#{Regexp.escape prefix}/ =~ w} if prefix

puts words
