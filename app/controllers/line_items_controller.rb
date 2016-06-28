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

  #Not implemented yet, must refactor to use ajax version in comprar page
  def destroy
    @line_item = LineItem.find(params[:id])
    @product.destroy
    redirect_to comprar_path
  end
end
