module SerializerHelper
  def date_created
    object.created_at.to_formatted_s(:db)
  end

  def date_modified
    object.updated_at.to_formatted_s(:db)
  end
end
