class OrdersController < ApplicationController
  def destroy
    @order = current_order
    @order.destroy
    session[:order_id] = nil

    respond_to do |format|
      format.html { redirect_to comprar_path }
      format.js
    end
  end
end
