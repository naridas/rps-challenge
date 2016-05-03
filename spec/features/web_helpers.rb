def sign_in_and_play
  visit "/"
  fill_in "player_name", :with => "Grig"
  click_button "Submit"
end
def computer_choice
  allow_any_instance_of(Array).to receive(:sample).and_return('Scissors')
  sign_in_and_play
end
