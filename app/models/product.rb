class Product < ApplicationRecord
  has_many :line_items
  has_many :orders, through: :line_items
  belongs_to :language

  before_destroy :ensure_not_referenced_by_any_line_item

  validates :language, :title, :description, :image_url, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true
  validates :title, length: { minimum: 10 }
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)\Z}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }

  def local_price(locale)
    return price if locale == :en
    price * exchange_rate
  end

  private

  # stubbed at the moment
  def exchange_rate
    1.2
  end

  def ensure_not_referenced_by_any_line_item
    return true if line_items.empty?
    errors.add(:base, 'Line Items present')
    throw :abort
  end
end
