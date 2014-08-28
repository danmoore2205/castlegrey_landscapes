require 'sinatra'

class App < Sinatra::Base

  set :haml, { :format => :html5 }

  get '/', :provides => :html do
    haml :index
  end

end