class PayType < ApplicationRecord
  validates :title, presence: true

  has_many :orders
end
