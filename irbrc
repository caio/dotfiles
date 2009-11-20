# Awesome IRB (mod'd) file from http://github.com/logankoester/irbrc
# Setup:
# sudo gem install wirble
# sudo gem install what_methods

# Make gems available
require 'rubygems'
 
# Dr Nic's gem inspired by
# http://redhanded.hobix.com/inspect/stickItInYourIrbrcMethodfinder.html
require 'what_methods'
 
# Pretty Print method
require 'pp'
 
# Load the readline module.
IRB.conf[:USE_READLINE] = true
 
# Remove the annoying irb(main):001:0 and replace with >>
IRB.conf[:PROMPT_MODE]  = :SIMPLE
 
# Tab Completion
require 'irb/completion'
 
# Automatic Indentation
IRB.conf[:AUTO_INDENT]=true
 
# Save History between irb sessions
require 'irb/ext/save-history'
IRB.conf[:SAVE_HISTORY] = 100
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"
 
# Wirble is a set of enhancements for irb
# http://pablotron.org/software/wirble/README
# Implies require 'pp', 'irb/completion', and 'rubygems'
require 'wirble'
Wirble.init
 
# Enable colored output
Wirble.colorize
 
# Clear the screen
def clear
  system 'clear'
  if ENV['RAILS_ENV']
    return "Rails environment: " + ENV['RAILS_ENV']
  end
end
 
# Shortcuts
alias c clear
 
# Method to pretty-print object methods
# Coded by sebastian delmont
# http://snippets.dzone.com/posts/show/2916
class Object
  ANSI_BOLD       = "\033[1m"
  ANSI_RESET      = "\033[0m"
  ANSI_LGRAY    = "\033[0;37m"
  ANSI_GRAY     = "\033[1;30m"
 
  # Print object's methods
  def pm(*options)
    methods = self.methods
    methods -= Object.methods unless options.include? :more
    filter = options.select {|opt| opt.kind_of? Regexp}.first
    methods = methods.select {|name| name =~ filter} if filter
 
    data = methods.sort.collect do |name|
      method = self.method(name)
      if method.arity == 0
        args = "()"
      elsif method.arity > 0
        n = method.arity
        args = "(#{(1..n).collect {|i| "arg#{i}"}.join(", ")})"
      elsif method.arity < 0
        n = -method.arity
        args = "(#{(1..n).collect {|i| "arg#{i}"}.join(", ")}, ...)"
      end
      klass = $1 if method.inspect =~ /Method: (.*?)#/
      [name, args, klass]
    end
    max_name = data.collect {|item| item[0].size}.max
    max_args = data.collect {|item| item[1].size}.max
    data.each do |item| 
      print " #{ANSI_BOLD}#{item[0].rjust(max_name)}#{ANSI_RESET}"
      print "#{ANSI_GRAY}#{item[1].ljust(max_args)}#{ANSI_RESET}"
      print "   #{ANSI_LGRAY}#{item[2]}#{ANSI_RESET}\n"
    end
    data.size
  end
end
 
# http://sketches.rubyforge.org/
# require 'sketches'
# Sketches.config :editor => 'mvim'
