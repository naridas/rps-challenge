require 'player'

describe Player do
  subject(:player) { Player.new("Grig") }
  let(:rock){ double :player_rps }

  describe "#name" do
    it "returns player's name" do
      expect(player.name).to eq("Grig")
    end
  end

  describe "#choice" do
    it "returns player's choice" do
      player.player_rps(rock)
      expect(player.choice).to eq(rock)
    end
  end
end
