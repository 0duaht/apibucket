require "rails_helper"

describe "BucketlistsController", type: :request do
  include_context "shared stuff"

  context "when version is not specified through Accept header" do
    it "fails to process request" do
      expect { get "/bucketlists" }.
        to raise_error ActionController::RoutingError
    end
  end

  context "when version is specified through Accept header" do
    it "processes request to create-bucketlist correctly" do
      post "/bucketlists", {}, HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
      expect(response.status).to eql(401)
    end

    it "processes request to list-all-bucketlists correctly" do
      get "/bucketlists", {}, HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
      expect(response.status).to eql(401)
    end

    it "processes request to get-single-bucketlist correctly" do
      get "/bucketlists/1", {}, HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
      expect(response.status).to eql(401)
    end

    it "processes 8request to update-single-bucketlist correctly" do
      put "/bucketlists/1", {}, HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
      expect(response.status).to eql(401)
    end

    it "processes request to delete-single-bucketlist correctly" do
      delete "/bucketlists/1", {},
             HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
      expect(response.status).to eql(401)
    end
  end

  context "token authentication" do
    context "when sending requests without a token" do
      it "returns an error message" do
        get "/bucketlists", {}, HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
        parsed_response = HashWithIndifferentAccess.new(
          JSON.parse(response.body)
        )
        expect(
          parsed_response[:errors][:request_authorization]
        ).to include("Token required")
      end
    end

    context "when sending requests with an invalid token" do
      it "returns an error message" do
        get "/bucketlists?token=asdflkadsf", {},
            HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
        parsed_response = HashWithIndifferentAccess.new(
          JSON.parse(response.body)
        )
        expect(
          parsed_response[:errors][:request_authorization]
        ).to include("Token invalid")
      end
    end

    context "when sending messages with a valid token" do
      it "returns a success message" do
        signin_helper
        parsed_response = HashWithIndifferentAccess.new(
          JSON.parse(response.body)
        )
        token = parsed_response[:token]

        get "/bucketlists", {},
            HTTP_AUTHORIZATION: "token #{token}",
            HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
        expect(response.status).to eql(200)
      end
    end
  end
end
