require 'game'

describe Game do
  subject(:game) { described_class.new(player_1, player_2) }
  let(:player_1){ double :player }
  let(:player_2){ double :player }


  describe "#attack" do
    it "attacks other player" do
      expect(player_2).to receive(:receive_damage)
      game.attack
    end
  end

  describe '#player_1' do
    it 'retrieves the first player' do
      expect(game.player_1).to eq player_1
    end
  end

end
