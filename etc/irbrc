require 'irb/completion'

require 'rubygems'
require 'wirble'

Wirble.init
Wirble.colorize

IRB.conf[:AUTO_INDENT] = true

# Tracing execution
def enable_trace( event_regex = /^(call|return)/, class_regex = /IRB|Wirble|RubyLex|RubyToken/ )
  puts "Enabling method tracing with event regex #{event_regex.inspect} and class exclusion regex #{class_regex.inspect}"

  set_trace_func Proc.new { |event, file, line, id, binding, classname|
    printf "[%8s] %30s %30s (%s:%-2d)\n", event, id, classname, file, line if
      event          =~ event_regex and
      classname.to_s !~ class_regex
  }
  return
end
def disable_trace
  puts "Disabling method tracing"

  set_trace_func nil
end
