require "rails_helper"

describe "SessionsController", type: :request do
  context "when version is not specified through Accept header" do
    it "fails to process request" do
      expect { post "/auth/login/" }.
        to raise_error ActionController::RoutingError
    end
  end

  context "when version is specified through Accept header" do
    it "processes request to log-in correctly" do
      post "/auth/login", {},
           HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
      expect(response).to be_successful
    end

    it "processes request to log-out correctly" do
      get "/auth/logout", {},
          HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
      expect(response).to be_successful
    end
  end
end
