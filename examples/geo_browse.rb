require 'rubygems'
require 'bundler'
Bundler.require
require 'sinatra'

#copied from https://gist.github.com/119874
#modifed to render haml instead of erb
module Sinatra::Partials
  def partial(template, *args)
    template_array = template.to_s.split('/')
    template = template_array[0..-2].join('/') + "/_#{template_array[-1]}"
    options = args.last.is_a?(Hash) ? args.pop : {}
    options.merge!(:layout => false)
    if collection = options.delete(:collection) then
      collection.inject([]) do |buffer, member|
        buffer << haml(:"#{template}", options.merge(:layout =>
        false, :locals => {template_array[-1].to_sym => member}))
      end.join("\n")
    else
      haml(:"#{template}", options)
    end
  end
end

helpers Sinatra::Partials

get '/application.css' do 
    content_type 'text/css', :charset => 'utf-8'
    scss :application
end

get '/reset.css' do 
    content_type 'text/css', :charset => 'utf-8'
    send_file('views/html5reset-1.6.1.css')
end

get '/application.js' do 
    content_type 'text/javascript', :charset => 'utf-8'
    send_file('views/application.js')
end

get '/' do
  @boos = AudioBoo.by_location(51.633,-0.064)
  haml :index 
end