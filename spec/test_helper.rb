module Api
  module Test
    shared_context "shared stuff" do
      before(:all) do
        DatabaseCleaner.strategy = :truncation
      end

      def signin_helper
        user = create(:user)
        post "/auth/login", { email: user.email, password: user.password },
             HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
      end

      after(:all) do
        DatabaseCleaner.clean
      end
    end
  end
end
