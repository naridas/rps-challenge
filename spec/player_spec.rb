require 'player'
  describe Player do
  subject(:player) { Player.new("Grig") }

  describe "#name" do
    it "returns player's name" do
      expect(player.name).to eq("Grig")
    end
  end
end
