class StaticPagesController < ApplicationController
  def inicio
  end

  def nuestros_productos
  end

  def comprar
    @categories = Category.all
    @order = current_order
  end

end
