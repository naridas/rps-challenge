require 'computer'

describe Computer do
  subject(:computer) { Computer.new }

  describe "#choice" do
    it "returns computer's choice" do
      rps = computer.computer_rps
      expect(computer.choice).to eq(rps)
    end
  end

  describe "#computer_rps" do
    it "sample an array" do
      allow_any_instance_of(Array).to receive(:sample).and_return('Scissors')
      expect(computer.computer_rps).to eq 'Scissors'
    end
  end

end
