require 'computer'

describe Computer do
  subject(:computer) { Computer.new }

  describe "#choice" do
    it "returns computer's choice" do
      rps = computer.computer_rps
      expect(computer.choice).to eq(rps)
    end
  end
end
