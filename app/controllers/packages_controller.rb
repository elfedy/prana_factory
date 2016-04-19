class PackagesController < ApplicationController

  def new
    @package = Package.new
  end

  def create
    @category = Category.find(params[:category_id])
    @package = @category.packages.create(package_params)

    # Create skus for all products, using the new package (replace with helper method or SkuUpdater method)
    @category.products.each do |product|
      @sku = @category.skus.create(product_id: product.id, package_id: @package.id)
      if product.premium
        @sku.price = @package.premium_price
      else
        @sku.price = @package.normal_price
      end
      @sku.save
    end
    redirect_to categories_path
  end

  def edit
    @category = Category.find(params[:category_id])
    @package = @category.packages.find(params[:id])
  end

  def update
    @category = Category.find(params[:category_id])
    @package = @category.packages.find(params[:id])
    @package.update(package_params)

    # Update all package's skus with new prices (replace with helper method or SkuUpdater method)
    @package.skus.each do |sku|
      if sku.product.premium
        sku.price = @package.premium_price
      else
        sku.price = @package.normal_price
      end
      sku.save
    end
    redirect_to categories_path
  end

  def destroy
    Package.find(params[:id]).destroy
    redirect_to categories_path
  end

  private

    def package_params
      params.require(:package).permit(:unit, :quantity, :premium_price, :normal_price)
    end

end
