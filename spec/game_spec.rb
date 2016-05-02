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
