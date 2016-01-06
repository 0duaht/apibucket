require "rails_helper"

describe "RootController", type: :request do
  include_context "shared stuff"

  it "redirects to documentation page when home page is visited" do
    get root_path
    expect(response).to redirect_to(api_documentation_url)
  end
end
