require 'spec_helper'

describe User do
  describe "passwords" do
    it "does not need a password and confirmation to save" do
      u = User.new(name: "steve", email: "steve@example.com")

      u.password = "password"

      u.save
      expect(u).to be_valid
    end

    it "requires an email" do
      u = User.new(name: "steve", password: "hunter2")

      u.save
      expect(u).to_not be_valid

      u.email = "steve@example.com"
      u.save
      expect(u).to be_valid
    end
  end

  describe "authentication" do
    let(:user) { User.create(name: "steve", password: "hunter2") }

    it "authenticates with a correct password" do
      expect(user.authenticate("hunter2")).to be
    end

    it "does not authenticate with an incorrect password" do
      expect(user.authenticate("hunter1")).to_not be
    end
  end
end
