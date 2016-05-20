class ApplicationController < ActionController::API
  before_filter :add_cross_origin_headers
  include CanCan::ControllerAdditions
  include ActionController::Serialization
  attr_reader :current_user

  def authenticate_token
    request_auth = Api::RequestAuthorization.call(request.headers, params)
    if request_auth.success?
      @current_user = request_auth.result
    else
      render json: request_auth.errors, status: :unauthorized
    end
  end

  def add_cross_origin_headers
    response.headers["Access-Control-Allow-Origin"] =
      request.headers["Origin"] || "*"
    response.headers["Access-Control-Allow-Credentials"] = "true"
  end

  rescue_from CanCan::AccessDenied do
    render json: { "message": "Unauthorized to access resource" },
           status: :unauthorized
  end
end
