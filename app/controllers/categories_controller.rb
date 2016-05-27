class CategoriesController < ApplicationController
  before_action :logged_in_admin

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
      flash[:notice] = "La categoría #{@category.name} ha sido creada"
      redirect_to categories_path
    else
      render 'new'
    end
  end

  def update
    @category = Category.find(params[:id])

    if @category.update_attributes(category_params)
      flash[:notice] = "La categoría #{@category.name} ha sido actualizada"
      redirect_to categories_path
    else
      render 'edit'
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @name = @category.name
    @category.destroy
    flash[:notice] = "La categoría #{@name} ha sido borrada"
    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name, :description, :image, products_attributes: [:id, :name],
                                      packages_attributes: [:units, :quantity])
  end
end
