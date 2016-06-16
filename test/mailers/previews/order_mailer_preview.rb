# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/order_mailer/order_confirmation_user
  def order_confirmation_user
    checkout = Checkout.first
    OrderMailer.order_confirmation_user(checkout)
  end

  # Preview this email at http://localhost:3000/rails/mailers/order_mailer/order_confirmation_admin
  def order_confirmation_admin
    checkout = Checkout.first
    OrderMailer.order_confirmation_admin(checkout)
  end

end
