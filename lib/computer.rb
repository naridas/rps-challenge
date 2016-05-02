class Computer
  attr_reader :name, :choice
  def initialize
    @array = Game::RPS
    @choice = nil
  end

  def computer_rps
    @choice = @array.sample
  end

end
