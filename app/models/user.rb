class User < ActiveRecord::Base
  include ErrorHandler

  has_many :bucketlists
  has_secure_password

  validates :email, uniqueness: { case_sensitive: false }, email_format: {
    message: "invalid. Please use a different one"
  }
end
