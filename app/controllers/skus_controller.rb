class SkusController < ApplicationController

  def index
    @category = Category.find(params[:category_id])
    @skus = @category.skus
  end

end
