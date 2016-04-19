class LineItemsController < ApplicationController
  def create
    @sku = Sku.find(params[:sku_id])
    @order = current_order
    @order.line_items.create(price: @sku.price, sku_id: @sku.id)
    @order.price += @sku.price
  end

  def destroy
  end
end
