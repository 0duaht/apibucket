require "rails_helper"

RSpec.describe Item, type: :model do
  context "when initializing" do
    it "fails without a name entry" do
      item = build(:item)
      item.name = ""
      expect(item).to be_invalid
    end

    it "initializes successfully with a name and bucketlist id" do
      item = build(:item)
      expect(item).to respond_to :bucketlist_id
      expect(item).to respond_to :name
      expect(item).to respond_to :done
      expect(item).to be_valid
    end
  end
end
