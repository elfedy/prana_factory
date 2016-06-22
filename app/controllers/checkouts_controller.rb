class CheckoutsController < ApplicationController
  before_action :logged_in_admin, only: [:index, :show]
  before_action :check_min_order_total_price, only: [:new]

  def new
    @checkout = Checkout.new
    @base_date = define_base_date
    @order = current_order

    # Temporary solution to redirect to comprar page if no line items are in the order.
    # Final solution will involve Ajax behaviour, disabling the button that links to the
    # checkouts new action, when there are no line items in the order.
    if @order.line_items.empty?
      flash[:error] = "Primero debes agregar productos a tu pedido"
      redirect_to comprar_path
    end
  end

  def create
    @base_date = define_base_date
    @checkout = Checkout.new(checkout_params)
    @checkout.add_line_items_from_order(current_order)

    if @checkout.valid?
      if @checkout.delivery_date >= @base_date
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
        flash[:error] = "La fecha de entrega puede ser a partir del #{@base_date}"
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

    def define_base_date
      base_date = Date.today + 1
      while Checkout::VALID_DELIVERY_WDAYS.exclude?(base_date.wday) do
        if base_date.wday == 6
          base_date = 0
        else
          base_date += 1
        end
      end
      return base_date
    end

    def check_min_order_total_price
      if current_order.total_price < Checkout::MIN_CHECKOUT_PRICE
        flash[:error] = "El pedido mínimo es de $#{Checkout::MIN_CHECKOUT_PRICE}"
        redirect_to comprar_path
      end
    end

end
