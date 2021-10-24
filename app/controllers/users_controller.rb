class UsersController < ApplicationController
  skip_before_action :authorized, only: [:create, :show]

  def create
    user = User.create(user_params)

    if user.valid?
      my_token = encode_token({user_id: user.id})
      render json: {user: UserSerializer.new(user), token: my_token}
    else
      render json: {error: "Username is taken. Please try a different username."}
    end
  end

  def show
    user = User.find(params[:id])
    render json: {user: UserSerializer.new(user)}
  end

  def destroy
    User.find(params[:id]).destroy

    render json: {message: "Your account has been deleted"}
  end

  #logged in user
  def profile
    render json: {user: UserSerializer.new(current_user)}, status: :accepted
  end

  private

  def user_params
    params.permit(:name, :password)
  end
end
