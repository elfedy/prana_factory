class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new(params.require(:category).permit(:name, :description))
    @category.save
    redirect_to categories_path
  end

  def update
  end

  def destroy
  end

  private

  def category_params
    params.require(:category).permit(:name, :description)
  end
end
