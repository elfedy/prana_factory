require 'test_helper'

class OrderMailerTest < ActionMailer::TestCase
  test "order_confirmation_user" do
    mail = OrderMailer.order_confirmation_user
    assert_equal "Order confirmation user", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "order_confirmation_admin" do
    mail = OrderMailer.order_confirmation_admin
    assert_equal "Order confirmation admin", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
