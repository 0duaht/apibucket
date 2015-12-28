require "rails_helper"

describe "SessionsController", type: :request do
  include_context "shared stuff"

  context "when version is not specified through Accept header" do
    it "processes with default api version - v1" do
      post "/auth/login", {}
      expect(response.status).to eql(401)
    end
  end

  context "when version is specified through Accept header" do
    it "processes request to log-in correctly" do
      post "/auth/login", {},
           HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
      expect(response.status).to eql(401)
    end

    it "processes request to log-out correctly" do
      get "/auth/logout", {},
          HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
      expect(response.status).to eql(401)
    end
  end

  context "when trying to log in" do
    it "fails when invalid authentication credentials are passed" do
      user = create(:user)

      post "/auth/login",
           { email: invalid_test_email, password: user.password },
           HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
      expect(response.status).to eql(401)

      user.destroy
    end

    it "succeeds when valid authentication credentials are passed" do
      user = create(:user)

      post "/auth/login", { email: user.email, password: user.password },
           HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
      expect(response.status).to eql(200)

      user.destroy
    end

    it "returns a token when valid authentication credentials are passed" do
      user = create(:user)
      post "/auth/login", { email: user.email, password: user.password },
           HTTP_ACCEPT: "application/vnd.apibucket.v1+json"

      parsed_response = JSON.parse(response.body)
      expect(parsed_response[:token]).to eql(user.api_token)

      user.destroy
    end
  end

  context "when trying to log out" do
    it "logs out successfully" do
      token = token_helper
      get "/auth/logout", {},
          HTTP_AUTHORIZATION: "token #{token}",
          HTTP_ACCEPT: "application/vnd.apibucket.v1+json"

      parsed_response = JSON.parse(response.body)
      expect(parsed_response["message"]).to eql("Logged out successfully.")

      get "/bucketlists", {},
          HTTP_AUTHORIZATION: "token #{token}",
          HTTP_ACCEPT: "application/vnd.apibucket.v1+json"

      parsed_response = JSON.parse(response.body)
      expect(parsed_response["message"]).to eql("Token invalid.")
    end
  end
end
