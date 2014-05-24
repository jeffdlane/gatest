class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.string :name
      t.string :ga_source
      t.string :ga_medium

      t.timestamps
    end
  end
end
