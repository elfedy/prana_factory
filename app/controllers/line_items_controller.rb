class LineItemsController < ApplicationController
  def create
    @sku = Sku.find(params[:sku_id])
    @order = current_order
    @line_item = @order.add_sku(@sku.id)
    @line_item.save

    redirect_to comprar_path
  end

  def destroy
  end
end
