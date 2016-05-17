class AdminsController < ApplicationController
  def index
    @admins = Admin.all
  end

  def new
    @admin = Admin.new
  end

  def create
    
  end

  def destroy
    @admin = Admin.find(params[:id])
    if @admin.destroy
      redirect_to admins_path
    end
  end

  def actions
  end
end
