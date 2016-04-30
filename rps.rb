require 'sinatra/base'

class RPS < Sinatra::Base
  enable :sessions

  get '/' do
    erb(:index)
  end

  post '/names' do
    session[:player_name] = params[:player_name]
    #player = Player.new(params[:player_name])
    #player_2 = Player.new(params[:player_2_name])
    redirect '/play'
  end

  get '/play' do
    @player_name = session[:player_name]
    erb(:play)
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
