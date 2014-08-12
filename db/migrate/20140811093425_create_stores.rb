class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.integer :owner_id

      t.timestamps
    end
  end
end
