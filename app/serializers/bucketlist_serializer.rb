class BucketlistSerializer < ActiveModel::Serializer
  include SerializerHelper

  attributes :id, :name, :items, :date_created, :date_modified, :created_by
  root false
  has_many :items, serializer: ItemSerializer

  def created_by
    object.user.name
  end
end
