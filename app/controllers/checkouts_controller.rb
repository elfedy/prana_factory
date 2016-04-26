class CheckoutsController < ApplicationController
  def new
    @checkout = Checkout.new
    @order = current_order
  end

  def create
    @checkout = Checkout.new(params[:checkout])
    @checkout.add_line_items_from_order(current_order)

    if @checkout.save
      Order.destroy(session[:order_id])
      session[:order_id] = nil
      redirect_to comprar_path
    end

  end

  def destroy
  end
end
