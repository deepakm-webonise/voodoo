class Api::V1::UsersController < ApplicationController
  before_filter :validate_new_user, only: [:register]
  before_filter :authorize_response, except: [:register]

  def register
    user = User.create(user_params)
    render json: if user.valid?
                   { data: { email: user.email,
                             api_key: user.api_key },
                     message: 'User registered successfully',
                     status: 201 }
                 else
                   { errors: { message: 'Email id is required' },
                     status: 403 }
                 end
  end

  def test_api
    api_key = request.headers['API-KEY']
    render json: if User.exists?(api_key: api_key)
                   { message: 'User is registered',
                     status: 200 }
                 else
                   { message: 'User not registered',
                     status: 403 }
                 end
  end

  private

  def validate_new_user
    user = User.find_by_email(params[:email])
    render json: { errors: { message: 'Email already registered' },
                   status: 403 } if user
  end

  def user_params
    params.permit(:email)
  end
end
