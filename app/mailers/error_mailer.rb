class ErrorMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.error_mailer.invalid_cart_id.subject
  #
  def invalid_cart_id(cart_id)
    @cart_id = cart_id
    mail to: 'admin@test.com', subject: 'Attempt to access invalid cart'
  end
end
