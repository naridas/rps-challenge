feature "Register name" do
  scenario "Input name" do
    sign_in_and_play
    expect(page).to have_text("Grig")
  end
end
