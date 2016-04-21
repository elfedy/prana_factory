class LineItemsController < ApplicationController
  def create
    @sku = Sku.find(params[:sku_id])
    @order = current_order
    @line_item = @order.add_sku(@sku.id)
    @line_item.save

    respond_to do |format|
       format.html { redirect_to(comprar_url) }
       format.js
    end
  end

  def destroy
  end
end
