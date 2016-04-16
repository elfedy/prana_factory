class PackagesController < ApplicationController

  def new
    @package = Package.new
  end

  def create
    Category.find(params[:category_id]).packages.create(package_params)
    redirect_to categories_path
  end

  def edit
    @category = Category.find(params[:category_id])
    @package = @category.packages.find(params[:id])
  end

  def update
    Category.find(params[:category_id]).packages.find(params[:id]).update(package_params)
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
