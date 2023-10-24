class Warehouse < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  validates :name, :code, :city, :description, :address, :cep, :area, presence: true
  validates :code, uniqueness: true
end
