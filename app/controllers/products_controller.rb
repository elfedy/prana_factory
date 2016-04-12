class ProductsController < ApplicationController

  def create
    Category.find(params[:category_id]).products.create(product_params)
    redirect_to categories_path
  end

  def new
    @product = Product.new
  end

  def destroy
    Product.find(params[:id]).destroy
    redirect_to categories_path
  end

  private

    def product_params
      params.require(:product).permit(:name)
    end

end
