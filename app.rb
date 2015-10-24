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
    @title = "Castlegrey Landscapes - Limerick based landscaping services"
    @meta_description = "Castlegrey Landscapes are a company based in the Limerick area. We specialise in full " +
    "landscaping and grounds maintenance services for your home or business."
    @images = Dir.new('public/images/homepage_carousel').select { |f| f.downcase.include? ".jpg" }
    @images.map! { |image| image.gsub(" ", "\ ") }
    haml :homepage
  end

  get '/services', :provides => :html do
    @title = "Services - Castlegrey Landscapes Limerick"
    @meta_description = "Castlegrey Landscapes provide many services including tree and shrub planting, patios &" +
    "paving, synthetic grass, new lawns, weed control, grounds maintenance and annaul maintenance contracts are available"
    haml :services
  end

  # get '/contact', :provides => :html do
  #   haml :contact_us
  # end

  get '/portfolio', :provides => :html do
    @title = "Portfolio - Castlegrey Landscapes Limerick"
    @meta_description = "View our portfolio of previous jobs completed."
    @images = Dir.new('public/images/homepage_carousel').select { |f| f.downcase.include? ".jpg" }
    @images.map! { |image| image.gsub(" ", "\ ") }
    haml :portfolio
  end

  post '/send_enquiry' do
    if params[:bot_buster] == "6"
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
      redirect '/'
    else
      flash[:notice] = "Please enter the correct answer to 4 + 2 in the box provided."
      redirect '/'
    end
  end

end