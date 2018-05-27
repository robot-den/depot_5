module OrdersHelper
  def prepare_pay_types_options
    options = PayType.pluck(:title, :id)
    return options if I18n.locale == :en
    options.map { |pair| t(".#{pair[0].parameterize(separator: '_')}") }
  end
end
