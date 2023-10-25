class Supplier < ApplicationRecord
  extend FriendlyId
  friendly_id :brand_name, use: :slugged
end
