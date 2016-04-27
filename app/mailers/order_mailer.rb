class OrderMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.order_confirmation_user.subject
  #
  def order_confirmation_user
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.order_confirmation_admin.subject
  #
  def order_confirmation_admin
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
