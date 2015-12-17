class User < ActiveRecord::Base
  has_many :bucketlists
  has_secure_password

  validates :name, presence: true
  validates :email, uniqueness: { case_sensitive: false }, email_format: {
    message: "invalid. Please use a different one"
  }
  def get_error
    all_errors = errors.full_messages
    all_errors ? all_errors[0] : "Invalid Entry. Please try again."
  end
end
