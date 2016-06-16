class OrderMailer < ApplicationMailer
  default :from => 'pedidos@pranafactory.com'

  include Roadie::Rails::Automatic

  def order_confirmation_user(checkout)
    @checkout = checkout
    mail :to => checkout.email, :subject => "PRANA FACTORY - Confirmación de Pedido"
  end

  def order_confirmation_admin(checkout)
    @checkout = checkout
    mail to: Rails.application.secrets.order_email_address, :subject => "Pedido #{checkout.address}"
  end

  private
end
