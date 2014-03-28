require 'spec_helper'

feature "Seed data" do
  scenario "Seed Data" do
    load Rails.root + "db/seeds.rb"
    user = User.where(email: "admin@example.com").first!
    project = Project.where(name: "Trotromate Beta").first!
  end
end
