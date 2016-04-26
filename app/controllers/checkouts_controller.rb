class CheckoutsController < ApplicationController
  def new
    @checkout = Checkout.new
    @order = current_order
  end

  def create
    @checkout = Checkout.new(checkout_params)
    @checkout.add_line_items_from_order(current_order)

    if @checkout.save
      Order.destroy(session[:order_id])
      session[:order_id] = nil
      redirect_to comprar_path
    end
  end

  def destroy
  end

  def index
    @checkouts = Checkout.all
  end

  def show
    @checkout = Checkout.find(params[:id])
  end

  private
    def checkout_params
      params.require(:checkout).permit(:name, :email, :address, :telephone, :delivery_date, :delivery_time)
    end
end
