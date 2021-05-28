require "awesome_print"
require 'hirb'

AwesomePrint.irb!

if defined? Rails::Console
  # Hirb.enableの有効化
  Hirb.enable if defined? Hirb
end

