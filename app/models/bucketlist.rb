class Bucketlist < ActiveRecord::Base
  include ErrorHandler

  belongs_to :user
  has_many :items
end
