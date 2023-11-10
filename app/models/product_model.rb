class ProductModel < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  def should_generate_new_friendly_id?
    name_changed?
  end
  belongs_to :supplier
  has_many :order_items
  has_many :stock_products
  has_many :orders, through: :order_items
  validates :name, :sku, presence: true
end
