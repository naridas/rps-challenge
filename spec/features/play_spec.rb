feature 'Playing RPS' do

  scenario 'see choices' do
    sign_in_and_play
    expect(page).to have_button 'Rock'
    expect(page).to have_button 'Scissors'
    expect(page).to have_button 'Paper'
  end

  scenario 'see what I selected after clicking' do
    sign_in_and_play
    click_button 'Rock'
    expect(page).to have_content 'You have clicked Rock'
  end

end
