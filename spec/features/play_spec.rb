feature 'Playing RPS' do

  scenario 'see choices' do
    sign_in_and_play
    expect(page).to have_button 'Rock'
    expect(page).to have_button 'Scissors'
    expect(page).to have_button 'Paper'
  end

end
