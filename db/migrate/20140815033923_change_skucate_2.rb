class ChangeSkucate2 < ActiveRecord::Migration
  def change
    rename_column :skucates, :name, :name1
    rename_column :skucates, :value, :value1

    add_column :skucates, :name2, :string
    add_column :skucates, :value2, :string

  end
end
