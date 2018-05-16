require 'test_helper'

class ErrorMailerTest < ActionMailer::TestCase
  test "invalid_cart_id" do
    mail = ErrorMailer.invalid_cart_id('x')
    assert_equal "Attempt to access invalid cart", mail.subject
    assert_equal ["admin@test.com"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Somebody try to access to invalid cart id: x", mail.body.encoded
  end

end
