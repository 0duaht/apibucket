module SaveHelper
  def save(object)
    if object.save
      render json: {
        "message": "#{object.class.name} saved successfully.",
        "id": object.id
      }, status: 201
    else
      render json: { "message": object.get_error },
             status: 400
    end
  end
end
