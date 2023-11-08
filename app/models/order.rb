class Order < ApplicationRecord
  belongs_to :warehouse
  belongs_to :supplier
  belongs_to :user
  enum status: { pending: 0, delivered: 5, canceled: 9 }
  validates :code, :estimated_delivery_date, presence: true

  validate :estimated_delivery_date_is_future

  before_validation :generates_code
  private

  def generates_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end

  def estimated_delivery_date_is_future
    unless self.estimated_delivery_date.present? && self.estimated_delivery_date > Date.today 
      self.errors.add(:estimated_delivery_date, "deve ser futura.")
    end
  end
end
