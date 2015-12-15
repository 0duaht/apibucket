require "rails_helper"

describe "ItemsController", type: :request do
  context "when version is not specified through Accept header" do
    it "fails to process request" do
      expect { post "/bucketlists/1/items/" }.
        to raise_error ActionController::RoutingError
    end
  end

  context "when version is specified through Accept header" do
    it "processes request to create-new-item-in-bucketlist correctly" do
      post "/bucketlists/1/items/", {},
           HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
      expect(response).to be_successful
    end

    it "processes request to update-an-item-in-bucketlist correctly" do
      put "/bucketlists/1/items/1", {},
          HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
      expect(response).to be_successful
    end

    it "processes request to delete-an-item-in-bucketlist correctly" do
      delete "/bucketlists/1/items/1", {},
             HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
      expect(response).to be_successful
    end
  end
end
