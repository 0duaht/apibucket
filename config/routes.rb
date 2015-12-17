Rails.application.routes.draw do
  def api_version_handler(version, &routes_block)
    constraint = ApiConstraint.new(version)
    namespace "#{version}".to_sym, path: "", constraints: constraint,
              &routes_block
  end

  namespace :api, path: "" do
    api_version_handler "v1" do
      resources :bucketlists, only:
        [:create, :destroy, :index,
         :show, :update] do
        resources :items, only: [:create, :destroy, :update]
      end

      scope :auth, path: "auth" do
        post "login" => "sessions#login"
        get "logout" => "sessions#logout"
      end
    end
  end
end
