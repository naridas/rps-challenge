feature 'Results of RPS' do

  scenario 'see what I selected after clicking' do
    sign_in_and_play
    click_button 'Rock'
    expect(page).to have_content 'You have clicked Rock'
  end

  scenario 'see what Computer selected' do
    allow_any_instance_of(Array).to receive(:sample).and_return('Scissors')
    sign_in_and_play
    click_button 'Rock'
    expect(page).to have_content 'Computer chose Scissors'
  end

  scenario 'win' do
    allow_any_instance_of(Array).to receive(:sample).and_return('Scissors')
    sign_in_and_play
    click_button 'Rock'
    expect(page).to have_content 'You win!'
  end

  scenario 'lose' do
    allow_any_instance_of(Array).to receive(:sample).and_return('Scissors')
    sign_in_and_play
    click_button 'Paper'
    expect(page).to have_content 'You lose!'
  end

  scenario 'lose' do
    allow_any_instance_of(Array).to receive(:sample).and_return('Scissors')
    sign_in_and_play
    click_button 'Scissors'
    expect(page).to have_content 'You draw!'
  end


end
