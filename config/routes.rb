Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :bucketlists, only:
        [:create, :destroy, :index,
         :show, :update] do
        resources :items, only: [:create, :destroy, :update]
      end
      namespace :auth do
        get "login" => "auth#login"
        get "logout" => "auth#logout"
      end
    end
  end
end
