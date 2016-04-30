feature "Register name" do
  scenario "Input name" do
    visit "/"
    fill_in "player_name", :with => "Grig"
    click_button "Submit"
    expect(page).to have_text("Hello Grig, let's play RPS!")
  end
end
