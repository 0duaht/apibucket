class ApplicationController < ActionController::API
  include CanCan::ControllerAdditions
  attr_reader :current_user

  def authenticate_token
    request_auth = Api::RequestAuthorization.call(request.headers, params)
    if request_auth.success?
      @current_user = request_auth.result
    else
      render json: { "errors": request_auth.errors },
             status: :unauthorized
    end
  end

  rescue_from CanCan::AccessDenied do
    render json: { "message": "Unauthorized to access resource" },
           status: :unauthorized
  end
end
