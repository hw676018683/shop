class ChangeSkucateRemoveSkulist < ActiveRecord::Migration
  def change
    add_column :skucates, :price, :decimal, precision: 10, scale: 2
    add_column :skucates, :quantity, :integer
    add_column :skucates, :oldprice, :decimal, precision: 10, scale: 2

    drop_table :skulists
  end
end
