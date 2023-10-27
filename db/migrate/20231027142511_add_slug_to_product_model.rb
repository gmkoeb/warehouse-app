class AddSlugToProductModel < ActiveRecord::Migration[7.0]
  def change
    add_column :product_models, :slug, :string
    add_index :product_models, :slug, unique: true
  end
end
