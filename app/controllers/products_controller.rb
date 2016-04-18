class ProductsController < ApplicationController

  def new
    @product = Product.new
  end

  def create
    @category = Category.find(params[:category_id])
    @product = @category.products.create(product_params)

    # Create skus for all packages, using the new product
    @category.packages.each do |package|
      @sku = @category.skus.create(product_id: @product.id, package_id: package.id)
      if @product.premium
        @sku.price = package.premium_price
      else
        @sku.price = package.normal_price
      end
      @sku.save
    end

    redirect_to categories_path
  end

  def edit
    @category = Category.find(params[:category_id])
    @product = @category.products.find(params[:id])
  end

  def update
    @category = Category.find(params[:category_id])
    @product = @category.products.find(params[:id])
    @product.update(product_params)

    # Update sku prices.
    @product.skus.each do |sku|
      if @product.premium
        sku.price = sku.package.premium_price
      else
        sku.price = sku.package.normal_price
      end
      sku.save
    end
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
