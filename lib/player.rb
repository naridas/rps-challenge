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
