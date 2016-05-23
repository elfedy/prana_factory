class SessionsController < ApplicationController
  def new
  end

  def create
    @admin = Admin.find_by(name: params[:session][:name])
    if @admin && @admin.authenticate(params[:session][:password])
      admin_login(@admin)
      flash[:notice] = "Has iniciado sessión"
      redirect_to admins_actions_path
    else
      flash[:error] = "El usuario y contraseña son inválidos"
      render 'new'
    end
  end

  def destroy
    admin_logout
    redirect_to root_path
  end

end
