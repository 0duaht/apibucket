require "rails_helper"

RSpec.describe Bucketlist, type: :model do
  context "when initializing" do
    it "fails without a name entry" do
      bucketlist = build(:bucketlist)
      bucketlist.name = ""
      expect(bucketlist).to be_invalid
    end
    it "initializes successfully with a name and user id" do
      bucketlist = build(:bucketlist)
      expect(bucketlist).to respond_to(:user_id)
      expect(bucketlist).to respond_to(:name)
      expect(bucketlist).to be_valid
    end
  end
end
