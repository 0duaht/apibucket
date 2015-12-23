class ApplicationController < ActionController::API
  def authenticate_token
    request_auth = Api::RequestAuthorization.call(request.headers, params)
    if request_auth.success?
      @current_user = request_auth.result
    else
      render json: { "errors": request_auth.errors },
             status: :unauthorized
    end
  end
end
