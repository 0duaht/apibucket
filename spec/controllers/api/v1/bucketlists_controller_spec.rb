require "rails_helper"

describe "BucketlistsController", type: :request do
  context "when version is not specified through Accept header" do
    it "fails to process request" do
      expect { get "/bucketlists" }.
        to raise_error ActionController::RoutingError
    end
  end

  context "when version is specified through Accept header" do
    it "processes request to create-bucketlist correctly" do
      post "/bucketlists", {}, HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
      expect(response).to be_successful
    end

    it "processes request to list-all-bucketlists correctly" do
      get "/bucketlists", {}, HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
      expect(response).to be_successful
    end

    it "processes request to get-single-bucketlist correctly" do
      get "/bucketlists/1", {}, HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
      expect(response).to be_successful
    end

    it "processes request to update-single-bucketlist correctly" do
      put "/bucketlists/1", {}, HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
      expect(response).to be_successful
    end

    it "processes request to delete-single-bucketlist correctly" do
      delete "/bucketlists/1", {},
             HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
      expect(response).to be_successful
    end
  end
end
