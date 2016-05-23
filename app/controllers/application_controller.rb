class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  private

    def current_order
      Order.find(session[:order_id])
    rescue ActiveRecord::RecordNotFound
      order = Order.create
      session[:order_id] = order.id
      order
    end

    def logged_in_admin
      unless admin_logged_in?
        redirect_to root_path
      end
    end
end
