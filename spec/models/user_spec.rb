require "rails_helper"

RSpec.describe User, type: :model do
  context "when initializing" do
    it "fails when name is absent" do
      user = build(:user)
      user.name = nil
      expect(user).to be_invalid
    end

    it "email is not passed in" do
      user = build(:user)
      user.email = nil
      expect(user).to be_invalid
    end

    it "email is not unique" do
      create(:user)
      user = build(:user)
      expect(user).to be_invalid
      expect(user.get_error).to eql("Email has already been taken")
    end
  end
end
