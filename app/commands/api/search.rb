module Api
  class Search
    attr_reader :objects, :params

    def initialize(objects, params)
      @objects = objects
      @params = params
    end

    def filter
      params[:q] ? objects.where("name LIKE ?", "%#{params[:q]}%") : objects
    end
  end
end
