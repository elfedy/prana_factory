require 'test_helper'

class CheckoutTest < ActiveSupport::TestCase

  def setup
    valid_delivery_date = Date.today + 1
    if valid_delivery_date.wday == 0
      valid_delivery_date = Date.today + 2
    end

    @checkout = Checkout.new(name: "Ejemplo",
                             email: "mail@ejemplo.com",
                             address: "Cucha Cucha 112",
                             telephone: "4433-5555",
                             delivery_date: valid_delivery_date,
                             delivery_time: "9:00h a 12:00h")
  end

  test "should accept valid checkout do" do
    assert @checkout.valid?
  end

  test "should accept valid emails" do
    valid_emails = [ "mail@ejemplo.com", "mail.88@ejemplo.com", "mail_88@ejemplo.com", "mail@ejemplo.com.ar"]
    valid_emails.each do |valid_email|
      @checkout.email = valid_email
      assert @checkout.valid?, "#{valid_email} should be valid"
    end
  end

  test "should reject invalid emails" do
    invalid_emails = [ "", "@camasutra", "sflksnflsnfls, mail@ejemplo"]
    invalid_emails.each do |invalid_email|
      @checkout.email = invalid_email
      assert_not @checkout.valid?, "#{invalid_email} should not be valid"
    end
  end
end
