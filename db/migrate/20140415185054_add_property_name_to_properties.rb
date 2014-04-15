class AddPropertyNameToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :property_name, :string
  end
end
