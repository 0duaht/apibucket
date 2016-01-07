require "rails_helper"

describe "ItemsController", type: :request do
  include_context "shared stuff"

  context "when sending messages with a valid token" do
    it "returns an error status when trying to create "\
    "an item with no parameters" do
      token = token_helper
      post "/bucketlists/#{random_id}/items", {},
           HTTP_AUTHORIZATION: "token #{token}",
           HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
      expect(response.status).to eql 400
    end

    it "returns an error status when trying to create "\
    "an item with no parameters" do
      token = token_helper
      post "/bucketlists/#{random_id}/items", {},
           HTTP_AUTHORIZATION: "token #{token}",
           HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
      expect(response.status).to eql 400
    end

    it "returns an error status when trying to create "\
    "an item with invalid parameters" do
      token = token_helper
      post "/bucketlists/#{random_id}/items", { "name": "N" },
           HTTP_AUTHORIZATION: "token #{token}",
           HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
      expect(response.status).to eql 400
    end

    it "processes requests successfully with default api version "\
      "when version is not specified with Accept header" do
      token = token_helper
      post "/bucketlists/#{random_id}/items",
           {
             "name": "New Item"
           },
           HTTP_AUTHORIZATION: "token #{token}"
      expect(response.status).to eql 201
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
      expect(response.status).to eql 201
    end

    it "returns an error status when trying to edit "\
    "an item with no parameters" do
      token = token_helper
      put "/bucketlists/#{random_id}/items/#{random_item_id}", {},
          HTTP_AUTHORIZATION: "token #{token}",
          HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
      expect(response.status).to eql 400
    end

    it "returns an error status when trying to edit "\
    "an item with invalid parameters" do
      token = token_helper
      put "/bucketlists/#{random_id}/items/#{random_item_id}", { "name": "N" },
          HTTP_AUTHORIZATION: "token #{token}",
          HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
      expect(response.status).to eql 400
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
      expect(response.status).to eql 200
    end

    it "returns an error status when trying to edit "\
    "an invalid item" do
      token = token_helper
      put "/bucketlists/#{random_id}/items/#{invalid_id}", {},
          HTTP_AUTHORIZATION: "token #{token}",
          HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
      expect(response.status).to eql 404
    end

    it "returns an unauthorized status when trying "\
      "to edit an item in a different user's bucketlist" do
      token = token_helper
      put "/bucketlists/#{random_id}/items/#{unauthorized_random_id}", {},
          HTTP_AUTHORIZATION: "token #{token}",
          HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
      expect(response.status).to eql 401
    end

    it "returns a success status when trying to delete "\
      "an item" do
        token = token_helper
        delete "/bucketlists/#{random_id}/items/#{random_item_id}", {},
               HTTP_AUTHORIZATION: "token #{token}",
               HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
        expect(response.status).to eql 200
      end
  end
end
