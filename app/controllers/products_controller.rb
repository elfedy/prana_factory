class ProductsController < ApplicationController

  def new
    @product = Product.new
  end

  def create
    @category = Category.find(params[:category_id])
    @product = @category.products.new(product_params)

    if @product.save
      # Create skus for all packages, using the new product (replace with helper method or SkuUpdater class method)
      @category.packages.each do |package|
        @sku = @category.skus.create(product_id: @product.id, package_id: package.id)
        if @product.premium
          @sku.price = package.premium_price
        else
          @sku.price = package.normal_price
        end
        @sku.save
      end
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
      # Update product's sku prices with new premium attribute. (replace with helper method or SkuUpdater method)
      @product.skus.each do |sku|
        if @product.premium
          sku.price = sku.package.premium_price
        else
          sku.price = sku.package.normal_price
        end
        sku.save
      end
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
