class CreateSkulists < ActiveRecord::Migration
  def change
    create_table :skulists do |t|
      t.integer :product_id
      t.float :price
      t.string :icon_url
      t.integer :quantity

      t.timestamps
    end
  end
end
