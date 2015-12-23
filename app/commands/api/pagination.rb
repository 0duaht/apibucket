module Api
  class Pagination
    attr_reader :objects, :params
    DEFAULT_LIMIT = 20
    DEFAULT_PAGE = 1

    def initialize(objects, params)
      @objects = objects
      @params = params
    end

    def start
      limit = params[:limit].to_i
      page = params[:page].to_i

      limit = limit.eql?(0) ? DEFAULT_LIMIT : limit
      limit = limit > 100 ? 100 : limit
      page = page.eql?(0) ? DEFAULT_PAGE : page

      paginate objects, limit, page
    end

    def paginate(objects, limit, page)
      begin_index = (page - 1) * limit
      end_index = begin_index + limit
      objects[begin_index...end_index]
    end
  end
end
