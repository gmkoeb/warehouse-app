class AddSlugToWarehouses < ActiveRecord::Migration[7.0]
  def change
    add_column :warehouses, :slug, :string
    add_index :warehouses, :slug, unique: true
  end
end
