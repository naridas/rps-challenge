class Computer
  attr_reader :name, :choice

  def initialize
    @array = ["Rock", "Paper", "Scissors"]
    @choice = nil
  end

  def computer_rps
    @choice = @array.sample
  end

end
