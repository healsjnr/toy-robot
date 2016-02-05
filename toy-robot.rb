$:.unshift(File.expand_path('./lib', __FILE__))
require './lib/robot.rb'
# > help # print usage.
if __FILE__ == $0
  require 'pry'
  binding.pry
end
