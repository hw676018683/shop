class DropProductIdFromCategory < ActiveRecord::Migration
  def change
    remove_column :categories, :product_id
  end
end
