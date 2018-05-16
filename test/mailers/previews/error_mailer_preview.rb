# Preview all emails at http://localhost:3000/rails/mailers/error_mailer
class ErrorMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/error_mailer/invalid_cart_id
  def invalid_cart_id
    ErrorMailer.invalid_cart_id
  end

end
