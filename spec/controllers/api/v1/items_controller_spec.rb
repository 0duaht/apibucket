require "rails_helper"

describe "ItemsController", type: :request do
  include_context "shared stuff"

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
      expect(response.status).to eql(401)
    end

    it "processes request to update-an-item-in-bucketlist correctly" do
      put "/bucketlists/1/items/1", {},
          HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
      expect(response.status).to eql(401)
    end

    it "processes request to delete-an-item-in-bucketlist correctly" do
      delete "/bucketlists/1/items/1", {},
             HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
      expect(response.status).to eql(401)
    end
  end

  context "when sending messages with a valid token" do
    it "returns an error status when trying to create "\
    "an item with no parameters" do
      token = token_helper
      post "/bucketlists/#{random_id}/items", {},
           HTTP_AUTHORIZATION: "token #{token}",
           HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
      expect(response.status).to eql(400)
    end

    it "returns an error status when trying to create "\
    "an item with no parameters" do
      token = token_helper
      post "/bucketlists/#{random_id}/items", {},
           HTTP_AUTHORIZATION: "token #{token}",
           HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
      expect(response.status).to eql(400)
    end

    it "returns an error status when trying to create "\
    "an item with invalid parameters" do
      token = token_helper
      post "/bucketlists/#{random_id}/items", { "name": "N" },
           HTTP_AUTHORIZATION: "token #{token}",
           HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
      expect(response.status).to eql(400)
    end

    it "returns a success status when trying to create "\
    "an item with valid parameters" do
      token = token_helper
      post "/bucketlists/#{random_id}/items",
           {
             "name": "New Item"
           },
           HTTP_AUTHORIZATION: "token #{token}",
           HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
      expect(response.status).to eql(201)
    end

    it "returns an error status when trying to edit "\
    "an item with no parameters" do
      token = token_helper
      put "/bucketlists/#{random_id}/items/#{random_item_id}", {},
          HTTP_AUTHORIZATION: "token #{token}",
          HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
      expect(response.status).to eql(400)
    end

    it "returns an error status when trying to edit "\
    "an item with invalid parameters" do
      token = token_helper
      put "/bucketlists/#{random_id}/items/#{random_item_id}", { "name": "N" },
          HTTP_AUTHORIZATION: "token #{token}",
          HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
      expect(response.status).to eql(400)
    end

    it "returns a success status when trying to edit "\
    "an item with valid parameters" do
      token = token_helper
      put "/bucketlists/#{random_id}/items/#{random_item_id}",
          {
            "name": "New Item",
            "done": true
          },
          HTTP_AUTHORIZATION: "token #{token}",
          HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
      expect(response.status).to eql(200)
    end

    it "returns an error status when trying to edit "\
    "an invalid item" do
      token = token_helper
      put "/bucketlists/#{random_id}/items/#{invalid_id}", {},
          HTTP_AUTHORIZATION: "token #{token}",
          HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
      expect(response.status).to eql(404)
    end

    it "returns a success status when trying to delete "\
      "an item" do
        token = token_helper
        delete "/bucketlists/#{random_id}/items/#{random_item_id}", {},
               HTTP_AUTHORIZATION: "token #{token}",
               HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
        expect(response.status).to eql(200)
      end
  end
end
