class UsersController < ApplicationController
  expose :user, -> { User.find_by(id: params[:id]) }
  expose :users, -> { User.includes(:account).order(created_at: :desc) }

  def index
    if users
      render json: users, each_serializer: UserSerializer, status: 200
    else
      render json: { errors: 'No users found' }, status: 404
    end
  end

  def show
    if user
      render json: user, serializer: UserSerializer, status: 200
    else
      render json: { errors: 'User not found' }, status: 404
    end
  end

  def create
    user = User.new(user_params)
    user.build_account(account_params)

    User.transaction do
      user.save!
      user.account.save!
    end

    if user.persisted?
      render json: user, serializer: UserSerializer, status: 200
    else
      render json: user.errors.full_messages, status: 400
    end
  end

  def update
    if user
      user.update(user_params)
      render json: user, serializer: UserSerializer, status: 200
    else
      render json: { errors: 'User not found' }, status: 404
    end
  end

  def destroy
    if user
      render json: { message: 'User deleted' }, status: 200
    else
      render json: { errors: 'User not found' }, status: 404
    end
  end

  private

  def user_params
    params.permit(:name, :age, :gender)
  end

  def account_params
    params.permit(:email, :password)
  end
end
