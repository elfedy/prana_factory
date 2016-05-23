class CheckoutsController < ApplicationController
  before_action :logged_in_admin, only: [:index, :show]

  def new
    @checkout = Checkout.new
    @order = current_order

    # Temporary solution to redirect to comprar page if no line items are in the order.
    # Final solution eill involve Ajax behaviour, disabling the button that links to the
    # checkouts new action, when there are no line items in the order.
    if @order.line_items.empty?
      flash[:error] = "Primero debes agregar productos a tu pedido"
      redirect_to comprar_path
    end
  end

  def create
    @checkout = Checkout.new(checkout_params)
    @checkout.add_line_items_from_order(current_order)

    if @checkout.valid?
      if @checkout.delivery_date > Date.today
        if @checkout.save
          Order.destroy(session[:order_id])
          session[:order_id] = nil
          OrderMailer.order_confirmation_user(@checkout).deliver_now
          OrderMailer.order_confirmation_admin(@checkout).deliver_now
          flash[:notice] = "Tu pedido se ha realizado con éxito"
          redirect_to comprar_path
        else
          @order = current_order
          render "new"
        end
      else
        flash[:error] = "La fecha de entrega debe ser a partir de mañana"
        @order = current_order
        render "new"
      end
    else
      @order = current_order
      render "new"
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
