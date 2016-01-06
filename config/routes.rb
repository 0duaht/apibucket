Rails.application.routes.draw do
  def api_version_handler(version, default = false, &routes_block)
    constraint = ApiConstraint.new(version, default)
    namespace "v#{version}".to_sym, path: "", constraints: constraint,
              &routes_block
  end

  root to: "root#index"

  namespace :api, path: "" do
    api_version_handler "1", true do
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
