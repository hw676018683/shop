class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.integer :user_id
      t.integer :skucate_id
      t.integer :quantity

      t.timestamps
    end
  end
end
