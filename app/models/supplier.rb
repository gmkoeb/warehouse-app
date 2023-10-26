class Supplier < ApplicationRecord
  extend FriendlyId
  friendly_id :brand_name, use: :slugged
  validates :corporate_name, :brand_name, :registration_number, :full_address, :city, :state, :email, presence: true
  validates :corporate_name, :registration_number, uniqueness: true
end
