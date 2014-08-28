require 'sinatra'

class App < Sinatra::Base

    set :haml, { :format => :html5 }

  get '/', :provides => :html do
    haml :index
  end

  get '/bar' do
    settings.respond_to?(:haml).to_s
  end

end