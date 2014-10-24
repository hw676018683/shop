class AddOrderToImglists < ActiveRecord::Migration
  def change
    add_column :imglists, :order, :integer
    remove_column :imglists, :main_img
  end
end
