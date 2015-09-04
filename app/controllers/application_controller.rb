class ApplicationController < ActionController::Base
  protect_from_forgery

  def authorize_response
    # intentionally used 'and' instead of '&&' to exit
    render json: { message: 'Invalid Api key', status: 401 } and return unless
      authenticated_user?
  end

  def authorize_user
    api_key = request.headers['API-KEY']
    user = User.find_by_api_key(api_key)
    # intentionally used 'and' instead of '&&' to exit
    render json: { message: 'Unauthorized', status: 401 } and return unless
      user && Job.find_by_id(params[:id]).user_id == user.id
  end

  private

  def authenticated_user?
    api_key = request.headers['API-KEY']
    api_key.present? && User.exists?(api_key: api_key)
  end
end
