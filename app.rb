require 'sinatra'
require 'pony'
require 'pry' if development?
require "sinatra/reloader" if development?

class App < Sinatra::Base

  set :haml, { :format => :html5 }

  get '/', :provides => :html do
    haml :homepage
  end

end