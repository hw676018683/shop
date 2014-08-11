class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.integer :category_id
      t.string :main_img
      t.integer :buy_limit

      t.timestamps
    end

    add_index :products, :name
  end
end
