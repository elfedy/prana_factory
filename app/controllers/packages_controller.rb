class PackagesController < ApplicationController
  def new
    @package = Package.new
  end

  def create
    Category.find(params[:category_id]).packages.create(package_params)
    redirect_to categories_path
  end

  def destroy
    Package.find(params[:id]).destroy
    redirect_to categories_path
  end

  private

    def package_params
      params.require(:package).permit(:unit, :quantity)
    end

end
