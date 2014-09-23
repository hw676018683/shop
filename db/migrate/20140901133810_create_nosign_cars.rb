class CreateNosignCars < ActiveRecord::Migration
  def change
    create_table :nosign_cars do |t|
      t.integer :nosign_id
      t.integer :skucate_id
      t.integer :quantity

      t.timestamps
    end
  end
end
