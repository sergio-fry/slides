require "rails_helper"

RSpec.feature "Admin home", type: :feature do
  scenario "open home page and see something" do
    visit "/admin"
    expect(page).to have_content "Hello!"
  end
end

