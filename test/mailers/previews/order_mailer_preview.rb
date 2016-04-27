# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/order_mailer/order_confirmation_user
  def order_confirmation_user
    OrderMailer.order_confirmation_user
  end

  # Preview this email at http://localhost:3000/rails/mailers/order_mailer/order_confirmation_admin
  def order_confirmation_admin
    OrderMailer.order_confirmation_admin
  end

end
