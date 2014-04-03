require 'spec_helper'

feature "Seed data" do
  scenario "Seed Data" do
    load Rails.root + "db/seeds.rb"
    user = User.where(email: "admin@example.com").first!
    project = Project.where(name: "Trotromate Beta").first!
  end

  scenario "The basics" do
    load Rails.root + "db/seeds.rb"
    user = User.find_by_email!("admin@example.com")
    visit '/signin'
    fill_in "Name", with: user.name
    fill_in "Password", with: "password"
    click_button "Sign in"
    expect(page).to have_content("Signed in successfully.")

    click_link "Trotromate Beta"
    click_link "New Ticket"
    fill_in "Title", with: "Comments with state"
    fill_in "Description", with: "Comments always have a state."
    click_button "Create Ticket"
    within("#comment_state_id") do
      expect(page).to have_content("New")
      expect(page).to have_content("Open")
      expect(page).to have_content("Closed")
    end
  end
end
