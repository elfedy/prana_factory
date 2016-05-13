class PackagesController < ApplicationController

  def new
    @package = Package.new
  end

  def create
    @category = Category.find(params[:category_id])
    @package = @category.packages.build(package_params)

    if @package.save
      @package.create_skus
      flash[:notice] = "El paquete #{@package.identifier} ha sido creado"
      redirect_to categories_path
    else
      render "new"
    end
  end

  def edit
    @category = Category.find(params[:category_id])
    @package = @category.packages.find(params[:id])
  end

  def update
    @category = Category.find(params[:category_id])
    @package = @category.packages.find(params[:id])

    if @package.update(package_params)
      @package.update_skus
      flash[:notice] = "el paquete #{@package.identifier} ha sido actualizado"
      redirect_to categories_path
    else
      render "edit"
    end
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
