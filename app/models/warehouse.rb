class Warehouse < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  def should_generate_new_friendly_id?
    name_changed?
  end
  
  validates :name, :code, :city, :description, :address, :cep, :area, presence: true
  validates :code, uniqueness: true
end
