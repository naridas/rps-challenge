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
