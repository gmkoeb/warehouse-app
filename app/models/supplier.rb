class Supplier < ApplicationRecord
  extend FriendlyId
  friendly_id :brand_name, use: :slugged

  def should_generate_new_friendly_id?
    brand_name_changed?
  end

  validates :corporate_name, :brand_name, :registration_number, :full_address, :city, :state, :email, presence: true

  validates :brand_name, :registration_number, uniqueness: true
end
