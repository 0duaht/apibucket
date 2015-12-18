module Api
  module V1
    class SessionsController < ApplicationController
      def login
        auth_command = Api::UserAuthentication.call(
          params[:email],
          params[:password]
        )
        respond_with_command(auth_command)
      end

      def logout
      end

      private

        def respond_with_command(auth_command)
          if auth_command.success?
            render json: { "token": auth_command.result }
          else
            render json: { "errors": auth_command.errors },
                   status: :unauthorized
          end
        end
    end
  end
end
