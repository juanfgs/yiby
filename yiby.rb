require 'sinatra'
require './lib/service'

set :public_folder, File.dirname(__FILE__) + '/public'

get '/api/:action' do
  service = Service.new "https://yts.re/api/#{params[:action]}.json"
  service.run().to_s
end

get '/' do
  @page = { :title => "Movies List", :subtitle => "A List of available movies"}
  serviceYify = Service.new "https://yts.re/api/list.json"
  @list = serviceYify.run()
  @list["MovieList"].each do |movie|
    omdb = Service.new "http://www.omdbapi.com/"
    { :i => movie["ImdbCode"], :plot => "full", :r => "json"  }.each do |param|
      omdb.add_param param
    end
    movie["imdbInfo"] = omdb.run()
  end
  erb :index
end
