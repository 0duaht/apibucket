Rails.application.routes.draw do
  def api_version_handler(version, &routes_block)
    constraint = ApiConstraint.new(version)
    namespace "v#{version}".to_sym, path: "", constraints: constraint,
              &routes_block
  end

  namespace :api, path: "" do
    api_version_handler "1" do
      resources :bucketlists, except: [:edit, :new] do
        resources :items, only: [:create, :destroy, :update]
      end

      scope :auth, path: "auth" do
        post "login" => "sessions#login"
        get "logout" => "sessions#logout"
      end

      scope :users, path: "users" do
        post "new" => "users#create"
      end
    end
  end
end
