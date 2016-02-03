$:.unshift(File.expand_path('../lib', __FILE__))
require 'bundler'
Bundler.setup(:default, :test)
require 'simplecov'
SimpleCov.start do
    add_filter '/vendor/'
end
