class ProductsController < ApplicationController
  before_action :logged_in_admin

  def new
    @product = Product.new
  end

  def create
    @category = Category.find(params[:category_id])
    @product = @category.products.new(product_params)

    if @product.save
      @product.create_skus
      flash[:notice] = "El producto #{@product.name} ha sido creado"
      redirect_to categories_path
    else
      render "new"
    end
  end

  def edit
    @category = Category.find(params[:category_id])
    @product = @category.products.find(params[:id])
  end

  def update
    @category = Category.find(params[:category_id])
    @product = @category.products.find(params[:id])
    if @product.update(product_params)
      @product.update_skus
      flash[:notice] = "El producto #{@product.name} ha sido actualizado"
      redirect_to categories_path
    else
      render 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @name = @product.name
    @product.destroy
    flash[:notice] = "El producto #{@name} ha sido borrado"
    redirect_to categories_path
  end

  private

    def product_params
      params.require(:product).permit(:name, :premium)
    end

end
