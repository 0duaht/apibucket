module Api
  module V1
    class UsersController < ApplicationController
      def create
        @user = User.new(user_params)
        if @user.save
          render plain: "Account Created Successfully"
        else
          render plain: @user.get_error
        end
      end

      private

        def user_params
          params.require(:user).
            permit(:name, :password, :email, :password_confirmation)
        end
    end
  end
end
