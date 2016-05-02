# RPS Challenge

Gems
-------
(assumption that we are working from a fork Challenge)
added gem 'rspec-sinatra' to gemfile

Instructions
-------
**Step 1 Basic structure**

```sh
$ git clone git@github.com:naridas/rps-challenge.git
$ cd rps-challenge
$ bundle
$ rspec-sinatra init --app RPS rps.rb
$ mkdir lib
$ mkdir views
$ cd spec
$ mkdir feature
$ cd ..
```

**Step 2 User Story 1**
(reused a lot of code from Battle)
Make a feature test for registering a name
Made '''register_name_spec.rb''' in '''features''' dir
added this inside the register_name_spec.rb

'''
feature "Register name" do
  scenario "Input name" do
    visit "/"
    fill_in "player_name", :with => "Grig"
    click_button "Submit"
    expect(page).to have_text("Hello Grig, let's play RPS.")
  end
end
'''

Change in rps.rb
'''
"Hello RPS!" => erb(:index)
'''

in view I created index.erb

```
<div align="center">
	<style>
	body {background-color: lightgrey;}
	h1   {color: darkred;}
	</style>
	<h1>Let's play RPS!</h1>
	<p>The rules are simples!<br><br> Rock beats Scissors, Scissors beats Paper and Paper beats Rock</p>
	<h2>Register to play</h2>
	<form action="/names" method="post">
	  <label for="player_name">
	    Player Name:<br><br>
	    <input type="text" name="player_name">
	  </label>
	  <br><br>
	  <input type="submit" value="Submit">
	</form>
</div>
```
add some routes for my player_name
```
enable :sessions

get '/' do
  erb(:index)
end

post '/names' do
  session[:player_name] = params[:player_name]
  redirect '/play'
end

get '/play' do
  @player_name = session[:player_name]
  erb(:play)
end
```
create play.erb

```
<div align="center">
Hello <%= @player_name %>, let's play RPS.
</div>
```
**Step 3 User Story 2**
create a new web helper web_helpers.rb and put it into the spec helper

```
def sign_in_and_play
  visit "/"
  fill_in "player_name", :with => "Grig"
  click_button "Submit"
end
```

create a test to see the RPS choices make a feature play_spec.rb
```
feature 'Playing RPS' do
  scenario 'see choices' do
    sign_in_and_play
    expect(page).to have_content 'Rock'
    expect(page).to have_content 'Scissors'
    expect(page).to have_content 'Paper'
  end
end
```
so my view for play.erb changes to
```
<div align="center">
  <h2>Hello <%= @player_name %>, let's play RPS!<br><br> Please choose what you want to play!</h2><br>
    <form action="/play" method="post">
      <input type="submit" name="rps" value="Rock"><br><br>
      <input type="submit" name="rps" value="Paper"><br><br>
      <input type="submit" name="rps" value="Scissors">
    </form>
</div>
```
make another test confirming choice called result_spec.rb on another routes
```
scenario 'see what I selected after clicking' do
  sign_in_and_play
  click_button 'Rock'
  expect(page).to have_content 'You have clicked Rock'
end
```
changes to rps.rb

```
post '/play' do
  session[:rps] = params[:rps]
  redirect '/result'
end

get '/result' do
  @rps = session[:rps]
  erb(:result)
end
```
make a result.erb

```
<div align="center">
<h2>You have clicked <%= @rps %></h2>
</div>
```
then need to show what the computer chose
```
scenario 'see what Computer selected' do
  allow_any_instance_of(Array).to receive(:sample).and_return('Scissors')
  sign_in_and_play
  click_button 'Rock'
  expect(page).to have_content 'Computer chose Scissors'
end
```
need something like this way you can see what the computer chose but this will cause problems since i need to start making a class to past this time unless i hardcode it.
```
<div align="center">
<h2>You have clicked <%= @player_rps %><br><br>
    Computer chose <%= @computer_rps %></h2>

</div>
```
so will start making my classes which are game, player and computer
lets start with player.rb and player_spec
```
require 'player'
describe Player do
  subject(:player) { Player.new("Grig") }

  describe "#name" do
    it "returns player's name" do
      expect(player.name).to eq("Grig")
    end
  end
end
```
then make the class
```
class Player
  attr_reader :name

  def initialize(name:)
    @name = name
  end

end
```
change my rps.rb
```
post '/names' do
  player = Player.new(params[:player_name])
  redirect '/play'
end
```
also want to be able to input my player_rps in player and see it so i know what choice they did
```
describe "#choice" do
  it "returns player's choice" do
    player.player_rps(rock)
    expect(player.choice).to eq(rock)
  end
end
```
which changed my player class to
```
class Player
  attr_reader :name, :choice

  def initialize(name)
    @name = name
    @choice = nil
  end

  def player_rps(player_rps)
    @choice = player_rps
  end

end

```
now have to make the computer class so the computer is able to chose a rps
```
require 'computer'

describe Computer do
  subject(:computer) { Computer.new }

  describe "#choice" do
    it "returns computer's choice" do
      rps = computer.computer_rps
      expect(computer.choice).to eq(rps)
    end
  end

  describe "#computer_rps" do
    it "sample an array" do
      allow_any_instance_of(Array).to receive(:sample).and_return('Scissors')
      expect(computer.computer_rps).to eq 'Scissors'
    end
  end

end
```
then make a computer class
```
class Computer
  attr_reader :name, :choice
  RPS = ["Rock", "Paper", "Scissors"]
  def initialize
    @array = RPS
    @choice = nil
  end

  def computer_rps
    @choice = @array.sample
  end

end

```
now have to create game class which interacts with computer and player


so my game_spec.rb
```
require 'game'

describe Game do
  subject(:game) { described_class.new(player, computer) }
  let(:player){ double :player }
  let(:computer){ double :computer }


  describe "#winner?" do
    it "attacks other player" do
      allow(player).to receive(:choice).and_return("Paper")
      allow(computer).to receive(:choice).and_return("Rock")
      expect(game.winner?).to eq true
    end
  end

  describe "#draw?" do
    it "attacks other player" do
      allow(player).to receive(:choice).and_return("Paper")
      allow(computer).to receive(:choice).and_return("Paper")
      expect(game.draw?).to eq true
    end
  end

  describe '#player' do
    it 'retrieves the player' do
      expect(game.player).to eq player
    end
  end
end
```
then my game class
```
class Game
	attr_reader :player, :computer
	RPS = ["Rock", "Paper", "Scissors"]
  BEATMAP = { 'Scissors' => 'Paper', 'Paper' => 'Rock', 'Rock' => 'Scissors' }
	def initialize(player, computer = Computer.new)
    @player = player
		@computer = computer
		@rules = BEATMAP
	end

	def draw?
	  return true if draw
		false
	end

	def winner?
		return true if winner
		false
	end

	def self.create(player, computer = Computer.new)
		@game = Game.new(player, computer = Computer.new)
	end

	def self.instance
		@game
	end

	private

	def draw
		@player.choice == @computer.choice
	end

	def winner
		@rules[@player.choice] == @computer.choice
	end
end

```
now i have all my classes now have to fix my routes
```
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

```
then need to make changes to result.erb
```
<div align="center">
<h2>You have clicked <%= @game.player.choice %><br><br>
    Computer chose <%= @game.computer.choice %></h2>
<% if @game.winner? %>
  <h1>You win!</h1>
<% elsif @game.draw? %>
  <h1>You draw!</h1>
<% else @game.draw? %>
  <h1>You lose!</h1>
<% end %>
<a href="/play">Play again!</a>
</div>

```
tbh should of made some feature tests...

```
feature 'Results of RPS' do

  scenario 'see what I selected after clicking' do
    sign_in_and_play
    click_button 'Rock'
    expect(page).to have_content 'You have clicked Rock'
  end

  scenario 'see what Computer selected' do
    allow_any_instance_of(Array).to receive(:sample).and_return('Scissors')
    sign_in_and_play
    click_button 'Rock'
    expect(page).to have_content 'Computer chose Scissors'
  end

  scenario 'win' do
    allow_any_instance_of(Array).to receive(:sample).and_return('Scissors')
    sign_in_and_play
    click_button 'Rock'
    expect(page).to have_content 'You win!'
  end

  scenario 'lose' do
    allow_any_instance_of(Array).to receive(:sample).and_return('Scissors')
    sign_in_and_play
    click_button 'Paper'
    expect(page).to have_content 'You lose!'
  end

  scenario 'lose' do
    allow_any_instance_of(Array).to receive(:sample).and_return('Scissors')
    sign_in_and_play
    click_button 'Scissors'
    expect(page).to have_content 'You draw!'
  end


end
```










# RPS Challenge: Rōnin Badge Test

Instructions
-------

* Challenge time: rest of the day and weekend, until Monday 9am
* Feel free to use google, your notes, books, etc. but work on your own
* If you refer to the solution of another coach or student, please put a link to that in your README
* If you have a partial solution, **still check in a partial solution**
* You must submit a pull request to this repo with your code by 9am Monday morning

Task
----

Knowing how to build web applications is getting us almost there as web developers!

The Makers Academy Marketing Array ( **MAMA** ) have asked us to provide a game for them. Their daily grind is pretty tough and they need time to steam a little.

Your task is to provide a _Rock, Paper, Scissors_ game for them so they can play on the web with the following user stories:

```sh
As a marketeer
So that I can see my name in lights
I would like to register my name before playing an online game

As a marketeer
So that I can enjoy myself away from the daily grind
I would like to be able to play rock/paper/scissors
```

Hints on functionality

- the marketeer should be able to enter their name before the game
- the marketeer will be presented the choices (rock, paper and scissors)
- the marketeer can choose one option
- the game will choose a random option
- a winner will be declared


As usual please start by

* Forking this repo
* TEST driving development of your app

**Rōnin BANZAI!!!!**

## Bonus level 1: Multiplayer

Change the game so that two marketeers can play against each other ( _yes there are two of them_ ).

## Bonus level 2: Rock, Paper, Scissors, Spock, Lizard

Use the _special_ rules ( you can find them here http://en.wikipedia.org/wiki/Rock-paper-scissors-lizard-Spock_ )

## Basic Rules

- Rock beats Scissors
- Scissors beats Paper
- Paper beats Rock

In code review we'll be hoping to see:

* All tests passing
* High [Test coverage](https://github.com/makersacademy/course/blob/master/pills/test_coverage.md) (>95% is good)
* The code is elegant: every class has a clear responsibility, methods are short etc.

Reviewers will potentially be using this [code review rubric](docs/review.md).  Referring to this rubric in advance may make the challenge somewhat easier.  You should be the judge of how much challenge you want this weekend.

Notes on test coverage
----------------------

Please ensure you have the following **AT THE TOP** of your spec_helper.rb in order to have test coverage stats generated
on your pull request:

```ruby
require 'coveralls'
require 'simplecov'

SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
Coveralls.wear!
```

You can see your [test coverage](https://github.com/makersacademy/course/blob/master/pills/test_coverage.md) when you submit a pull request, and you can also get a summary locally by running:

```
$ coveralls report
```

This repo works with [Coveralls](https://coveralls.io/) to calculate test coverage statistics on each pull request.


# RPS Challenge: Rōnin Badge Test
