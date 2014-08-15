class CreateImglists < ActiveRecord::Migration
  def change
    create_table :imglists do |t|
      t.integer :product_id
      t.string :img
      t.boolean :main_img, default: false

      t.timestamps
    end
  end
end
