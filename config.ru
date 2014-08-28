require './app.rb'
require 'sass/plugin/rack'
require 'haml'

Sass::Plugin.options[:style] = :compressed
use Sass::Plugin::Rack

run App.new