class AuthController < ApplicationController
  skip_before_action :authorized, only: [:create, :show]

  # for login
  def create
    user = User.find_by(name: params[:name])

    if user && user.authenticate(params[:password])
      token = encode_token({user_id: user.id})

      render json: {id: UserSerializer.new(user), token: token}
    else
      render json: {error: 'Please a valid user name address and password'}, status: :unauthorized
    end
  end

  def show
    user = User.find(params[:id])
    render json: UserSerializer.new(user)
  end

end
