class AddIndexMuliTable < ActiveRecord::Migration
  def change
  add_index :admin_owners, :email, unique: true
  add_index :admin_owners, :remember_token

  add_index :carousels, :store_id
  add_index :cars, :user_id

  add_index :categories, :store_id
  add_index :collecting_relationships, :user_id

  add_index :comments, :user_id
  add_index :comments, :product_id
  add_index :comments, :reply_id

  add_index :details, :product_id
  add_index :imglists, :product_id

  add_index :nosign_cars, :nosign_id

  add_index :products, [:category_id, :status]

  add_index :properties, :product_id
  add_index :replies, :comment_id

  add_index :skucates, :product_id
  add_index :skucates, [:name1, :value1, :name2, :value2]

  add_index :skulists, :skucate_id
  add_index :stores, :owner_id

  end
end
