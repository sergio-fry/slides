require "rails_helper"

RSpec.feature "OpenRoots", type: :feature do
  scenario "open home page and see something" do
    visit "/"
    expect(page).to have_content "Hello!"
  end
end
