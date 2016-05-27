#Tecnically they are not static pages so controller must be renamed to "User Pages" or similar

class StaticPagesController < ApplicationController
  def inicio
  end

  def nuestros_productos
    @categories = Category.all
  end

  def comprar
    @categories = Category.all
    @order = current_order
  end

end
