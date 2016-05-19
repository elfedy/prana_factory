class SessionsController < ApplicationController
  def new
  end

  def create
    @admin = Admin.find_by(name: params[:session][:name])
    if @admin && @admin.authenticate(params[:session][:password])
      login(@admin)
      flash[:notice] = "Has iniciado sessión"
      redirect_to admins_actions path
    else
      flash[:error] = "El usuario y contraseña son inválidos"
      render 'new'
    end
  end
end
