module Api
  module Test
    shared_context "shared stuff" do
      let(:random_id) do
        User.first.bucketlists.order("RANDOM()").first.id
      end
      let(:unauthorized_random_id) do
        User.last.bucketlists.order("RANDOM()").first.id
      end
      let(:random_item_id) do
        User.first.bucketlists.last.items.order("RANDOM()").first.id
      end
      let(:valid_email) { "user1@seed.com" }
      let(:test_email) { "test@seed.com" }
      let(:invalid_test_email) { "test seed" }
      let(:test_pass) { "testpass" }
      let(:valid_pass) { "user1pass" }
      let(:invalid_id) { "u" }

      before(:all) do
        DatabaseCleaner.strategy = :truncation
      end

      def signin_helper(email = valid_email, pass = valid_pass)
        post "/auth/login", { email: email, password: pass },
             HTTP_ACCEPT: "application/vnd.apibucket.v1+json"
      end

      def token_helper(email = valid_email, pass = valid_pass)
        signin_helper(email, pass)
        parsed_response = HashWithIndifferentAccess.new(
          JSON.parse(response.body)
        )

        parsed_response[:token]
      end

      after(:all) do
        DatabaseCleaner.clean
      end
    end
  end
end
