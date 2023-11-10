class StockProduct < ApplicationRecord
  belongs_to :warehouse
  belongs_to :order
  belongs_to :product_model
  has_one :stock_product_destination
  before_validation :generates_serial_number, on: :create
  private

  def generates_serial_number
    self.serial_number = SecureRandom.alphanumeric(20).upcase
  end
end
