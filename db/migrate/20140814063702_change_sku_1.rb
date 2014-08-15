class ChangeSku1 < ActiveRecord::Migration
  def change
    add_column :skucates, :product_id, :integer
    remove_column :skulists, :product_id
  end
end
