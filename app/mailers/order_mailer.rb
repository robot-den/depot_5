class OrderMailer < ApplicationMailer
  default from: 'Denis Nazmutdinov <depot_5@example.com>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.received.subject
  #
  def received(order)
    @order = order
    mail to: order.email, subject: 'Pragmatic store order confirmation'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.shipped.subject
  #
  def shipped(order)
    @from_mailer = true
    @order = order
    mail to: order.email, subject: 'Pragmatic store order shipped'
  end
end
