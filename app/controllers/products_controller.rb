class ProductsController < ApplicationController

  def new
    @product = Product.new
  end

  def create
    Category.find(params[:category_id]).products.create(product_params)
    redirect_to categories_path
  end

  def edit
    @category = Category.find(params[:category_id])
    @product = @category.products.find(params[:id])
  end

  def update
    Category.find(params[:category_id]).products.find(params[:id]).update(product_params)
    redirect_to categories_path
  end

  def destroy
    Product.find(params[:id]).destroy
    redirect_to categories_path
  end

  private

    def product_params
      params.require(:product).permit(:name, :premium)
    end

end
