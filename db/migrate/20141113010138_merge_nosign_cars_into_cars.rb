class MergeNosignCarsIntoCars < ActiveRecord::Migration
  def change
    add_column :cars, :nosign_id, :string
    rename_table :cars, :items
    drop_table :nosign_cars
  end
end
