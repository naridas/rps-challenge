require 'sinatra/base'
require './lib/player'
require './lib/game'
require './lib/computer'

class RPS < Sinatra::Base
  enable :sessions

  get '/' do
    erb(:index)
  end

  before do
    @game = Game.instance
  end

  post '/names' do
    player = Player.new(params[:player_name])
    @game = Game.create(player)
    redirect '/play'
  end

  get '/play' do
    @game = Game.instance
    erb(:play)
  end

  post '/play' do
    @game.player.player_rps(params[:rps])
    @game.computer.computer_rps
    redirect '/result'
  end

  get '/result' do
    erb(:result)
  end


  # start the server if ruby file executed directly
  run! if app_file == $0
end
