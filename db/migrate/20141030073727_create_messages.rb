class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.integer :store_id
      t.integer :product_id
      t.integer :code
      t.boolean :status
 
      t.timestamps
    end

    add_index :messages, :user_id
  end
end
