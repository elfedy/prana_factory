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
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path
    else
      render 'new'
    end
  end

  def update
    Category.find(params[:id]).update(category_params)
    redirect_to categories_path
  end

  def destroy
    Category.find(params[:id]).destroy
    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name, :description, products_attributes: [:id, :name],
                                      packages_attributes: [:units, :quantity])
  end
end
