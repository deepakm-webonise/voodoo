class User < ActiveRecord::Base
  before_validation :generate_api_key, on: :create
  validates :email, :api_key, presence: true
  has_many :jobs

  private

  def generate_api_key
    loop do
      token = SecureRandom.base64.tr('+/=', 'dym')
      unless User.exists?(api_key: token)
        self.api_key = token
        break
      end
    end
  end
end
