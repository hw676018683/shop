class ChangeSku < ActiveRecord::Migration
  def change
    add_column :skulists, :skucate_id, :integer
    remove_column :skucates, :skulist_id
  end
end
