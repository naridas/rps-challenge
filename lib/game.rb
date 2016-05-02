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
