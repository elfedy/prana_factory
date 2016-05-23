class AdminsController < ApplicationController
  before_action :logged_in_admin

  def index
    @admins = Admin.all
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      flash[:notice] = "El administrador #{@admin.name} has sido creado"
      redirect_to admins_path
    else
      render 'new'
    end
  end

  def destroy
    @admin = Admin.find(params[:id])
    if @admin.destroy
      redirect_to admins_path
    end
  end

  def actions
  end

  private

    def user_params
      admin.require(:admin).permit(:name, :email, :password, :password_confirmation)
    end
end
