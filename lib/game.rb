
class Game
	attr_reader player

	def initialize(player)
    @player = player
	end

	def self.create
		@game = Game.new(player)
	end

	def self.instance
		@game
	end

end

# def rps(p1, p2)
#   beatmap = { 'scissors' => 'paper', 'paper' => 'rock', 'rock' => 'scissors' }
#   if p1 == p2
#     "Draw!"
#   elsif beatmap[p1] == p2
#     "Player 1 won!"
#   else
#     "Player 2 won!"
#   end
# end
