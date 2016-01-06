class RootController < ApplicationController
  def index
    redirect_to "http://docs.apibucket.apiary.io/"
  end
end
