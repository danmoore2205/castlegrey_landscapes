require 'sinatra'
require 'pony'
require 'rack-flash'
if ENV['RACK_ENV'] == "development"
  require 'pry'
  require 'pry-remote'
  require 'sinatra/reloader'
end

class App < Sinatra::Base
  enable :sessions
  use Rack::Flash

  configure :development do
    register Sinatra::Reloader
  end

  set :haml, { :format => :html5 }

  get '/', :provides => :html do
    @images = Dir.new('public/images/homepage_carousel').select { |f| f.downcase.include? ".jpg" }
    @images.map! { |image| image.gsub(" ", "\ ") }
    haml :homepage
  end

  get '/contact', :provides => :html do
    haml :contact_us
  end

  post '/send_enquiry' do
    Pony.mail(
      :to => ENV['TO_EMAIL'],
      :from => ENV['FROM_EMAIL'],
      :subject => "#{params[:name]} has made an enqury.",
      :body => haml(:enquiry_email, layout: false),
      :via => :smtp,
      :via_options => {
        :address              => 'smtp.gmail.com',
        :port                 => '587',
        :enable_starttls_auto => true,
        :user_name            => ENV['EMAIL_USERNAME'],
        :password             => ENV['EMAIL_PASSWORD'],
        :authentication       => :plain # :plain, :login, :cram_md5, no auth by default
      }
    )
    flash[:notice] = "Thanks for your enquiry, we'll be in touch soon."
    redirect '/contact'
  end

end