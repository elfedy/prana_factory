class OrdersController < ApplicationController
  def destroy
    @order = current_order
    @order.destroy
    session[:order_id] = nil
    redirect_to comprar_path
  end
end
