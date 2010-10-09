begin
  require 'irbtools/configure'
  Irbtools.libs -= ['irb_rocket']
  Irbtools.init
rescue LoadError

  def try_require module_name, &block
    begin
      require module_name
      yield unless block.nil?
    rescue LoadError
      $stderr.puts "Error: Unable to load \"#{module_name}\""
    end
  end
  try_require 'what_methods'
  try_require 'pp'

  # Load the readline module.
  IRB.conf[:USE_READLINE] = true

  # Remove the annoying irb(main):001:0 and replace with >>
  IRB.conf[:PROMPT_MODE]  = :SIMPLE

  # Tab Completion
  require 'irb/completion'

  # Automatic Indentation
  IRB.conf[:AUTO_INDENT]=true

  # Save History between irb sessions
  try_require 'irb/ext/save-history'
  IRB.conf[:SAVE_HISTORY] = 100
  IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"

  try_require 'wirble' do
    Wirble.init
    Wirble.colorize
  end

  # Clear the screen
  def clear
    system 'clear'
    if ENV['RAILS_ENV']
      return "Rails environment: " + ENV['RAILS_ENV']
    end
  end
  alias c clear

end
