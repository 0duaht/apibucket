require "rails_helper"

describe "UsersController", type: :request do
  include_context "shared stuff"

  context "when trying to sign" do
    it "fails to sign up when parameters are invalid" do
      user = build(:user)
      post "/users/new",
           {
             name: user.name,
             email: invalid_test_email,
             password: user.password,
             password_confirmation: user.password
           },
           HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
      expect(response.status).to eql(400)
    end

    it "signs up successfully when parameters are valid" do
      user = build(:user)
      post "/users/new",
           {
             name: user.name,
             email: user.email,
             password: user.password,
             password_confirmation: user.password
           },
           HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
      expect(response.status).to eql(200)
    end
  end
end
