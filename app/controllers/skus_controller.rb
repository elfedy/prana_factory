class SkusController < ApplicationController
  before_action :logged_in_admin

  def index
    @category = Category.find(params[:category_id])
    @skus = @category.skus
  end

end
