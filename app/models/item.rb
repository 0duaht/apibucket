class Item < ActiveRecord::Base
  include ErrorHandler

  belongs_to :bucketlist
end
