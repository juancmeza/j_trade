class ApplicationController < ActionController::Base

  before_action :authorized

  protect_from_forgery unless: -> { request.format.json? }

  def encode_token(payload)
    # Hide secret
    JWT.encode(payload, "super secret string")
  end

  def auth_header
    # {Authorization: 'Bearer <token>'}
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]
      # Header: {'Authorization': 'Bearer <token>'}
      begin
        # Making sure secret matches encode_token secret
        JWT.decode(token, "super secret string", true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def current_user
    if decoded_token
      user_id = decoded_token[0]['user_id']
      @user = User.find_by(id: user_id)
    end
  end

  def logged_in?
    # Coerce user
    !!current_user
  end

  def authorized
    render json: { message: 'You must be logged in to see this page' }, status: :unauthorized unless logged_in?
  end
end
