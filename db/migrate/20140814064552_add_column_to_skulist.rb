class AddColumnToSkulist < ActiveRecord::Migration
  def change
    add_column :skulists, :oldprice, :float
  end
end
