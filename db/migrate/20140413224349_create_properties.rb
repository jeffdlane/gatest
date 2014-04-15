class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :ga_property_id
      t.string :custom_data_id

      t.timestamps
    end
  end
end
