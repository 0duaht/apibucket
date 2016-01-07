require "rails_helper"

describe "BucketlistsController", type: :request do
  include_context "shared stuff"

  context "when version is not specified through Accept header" do
    it "processes with default api version - v1" do
      get "/bucketlists"
      expect(response.status).to eql 401
    end
  end

  context "when version is specified through Accept header" do
    it "processes request to create-bucketlist correctly" do
      post "/bucketlists", HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
      expect(response.status).to eql 401
    end

    it "processes request to list-all-bucketlists correctly" do
      get "/bucketlists", HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
      expect(response.status).to eql 401
    end

    it "processes request to get-single-bucketlist correctly" do
      get "/bucketlists/1", HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
      expect(response.status).to eql 401
    end

    it "processes request to update-single-bucketlist correctly" do
      put "/bucketlists/1", HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
      expect(response.status).to eql 401
    end

    it "processes request to delete-single-bucketlist correctly" do
      delete "/bucketlists/1",
             HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
      expect(response.status).to eql 401
    end
  end

  context "token authentication" do
    context "when sending requests without a token" do
      it "returns an error message" do
        get "/bucketlists", HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
        parsed_response = JSON.parse(response.body)
        expect(
          parsed_response["message"]
        ).to include "Token required"
      end
    end

    context "when sending requests with an invalid token" do
      it "returns an error message" do
        get "/bucketlists?token=asdflkadsf",
            HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
        parsed_response = JSON.parse(response.body)
        expect(
          parsed_response["message"]
        ).to include "Token invalid"
      end
    end

    context "when sending messages with a valid token" do
      it "returns a success message when trying to view bucketlists" do
        token = token_helper
        get "/bucketlists", {},
            HTTP_AUTHORIZATION: "token #{token}",
            HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
        expect(response.status).to eql 200
      end

      it "returns an error status when trying to create "\
      "a bucketlist with no parameters" do
        token = token_helper
        post "/bucketlists", {},
             HTTP_AUTHORIZATION: "token #{token}",
             HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
        expect(response.status).to eql 400
      end

      it "returns a success status when trying to create "\
      "a bucketlist with valid parameters" do
        token = token_helper
        post "/bucketlists", { "name": "New Bucketlist" },
             HTTP_AUTHORIZATION: "token #{token}",
             HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
        expect(response.status).to eql 201
      end

      it "returns a success status when trying to view a bucketlist" do
        token = token_helper
        get "/bucketlists/#{random_id}", {},
            HTTP_AUTHORIZATION: "token #{token}",
            HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
        expect(response.status).to eql 200
      end

      it "returns a success status when trying to view an empty bucketlist" do
        user = create(:user)
        token = token_helper(user.email, user.password)
        get "/bucketlists", {},
            HTTP_AUTHORIZATION: "token #{token}",
            HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
        expect(response.status).to eql 204

        user.destroy
      end

      it "returns an error status when trying to view an invalid bucketlist" do
        token = token_helper
        get "/bucketlists/#{invalid_id}", {},
            HTTP_AUTHORIZATION: "token #{token}",
            HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
        expect(response.status).to eql 404
      end

      it "returns an unauthorized status when trying "\
        "to view a different user's bucketlist" do
        token = token_helper
        get "/bucketlists/#{unauthorized_random_id}", {},
            HTTP_AUTHORIZATION: "token #{token}",
            HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
        expect(response.status).to eql 401
      end

      it "returns a success status when trying to edit "\
      "a bucketlist with valid parameters" do
        token = token_helper
        put "/bucketlists/#{random_id}", { "name": "New Bucketlist" },
            HTTP_AUTHORIZATION: "token #{token}",
            HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
        expect(response.status).to eql 200
      end

      it "returns an error status when trying to edit "\
      "a bucketlist with invalid parameters" do
        token = token_helper
        put "/bucketlists/#{random_id}", { "name": "s" },
            HTTP_AUTHORIZATION: "token #{token}",
            HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
        expect(response.status).to eql 400
      end

      it "returns an error status when trying to edit "\
      "a bucketlist with no parameters" do
        token = token_helper
        put "/bucketlists/#{random_id}", {},
            HTTP_AUTHORIZATION: "token #{token}",
            HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
        expect(response.status).to eql 400
      end

      it "returns a success status when trying to delete "\
      "a bucketlist" do
        token = token_helper
        delete "/bucketlists/#{random_id}", {},
               HTTP_AUTHORIZATION: "token #{token}",
               HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
        expect(response.status).to eql 200
      end
    end

    context "pagination test" do
      it "sends 20 bucketlists when limit is not specified" do
        token = token_helper
        get "/bucketlists", {},
            HTTP_AUTHORIZATION: "token #{token}",
            HTTP_ACCEPT: "application/vnd.apibucket.v1+json"

        parsed_response = JSON.parse(response.body)
        expect(parsed_response.count).to eql 20
      end

      it "replies with appropriate number of bucketlists "\
        "when limit is specified" do
        token = token_helper
        count = 35
        get "/bucketlists?limit=#{count}", {},
            HTTP_AUTHORIZATION: "token #{token}",
            HTTP_ACCEPT: "application/vnd.apibucket.v1+json"

        parsed_response = JSON.parse(response.body)
        expect(parsed_response.count).to eql count
      end

      it "defaults to 100 when limit specified is greater than 100" do
        token = token_helper
        count = 115
        get "/bucketlists?limit=#{count}", {},
            HTTP_AUTHORIZATION: "token #{token}",
            HTTP_ACCEPT: "application/vnd.apibucket.v1+json"

        parsed_response = JSON.parse(response.body)
        expect(parsed_response.count).to eql 100
      end

      it "serves correct page when page is specified" do
        token = token_helper
        count = 50
        page = 2
        get "/bucketlists?limit=#{count}&page=#{page}", {},
            HTTP_AUTHORIZATION: "token #{token}",
            HTTP_ACCEPT: "application/vnd.apibucket.v1+json"

        parsed_response = JSON.parse(response.body)
        expect(parsed_response.first["name"]).to eql "Bucketlist 51"
        expect(parsed_response.last["name"]).to eql "Bucketlist 100"
      end
    end

    context "while searching" do
      it "returns no bucketlists if none match the search parameter" do
        token = token_helper
        match = "non-match"
        get "/bucketlists?q=#{match}", {},
            HTTP_AUTHORIZATION: "token #{token}",
            HTTP_ACCEPT: "application/vnd.apibucket.v1+json"

        expect(response.status).to eql 204
      end
    end
  end
end
