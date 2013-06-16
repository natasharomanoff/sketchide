require 'bundler/setup'
Bundler.require(:default)


require File.dirname(__FILE__) + '/app'


run Sinatra::Application
