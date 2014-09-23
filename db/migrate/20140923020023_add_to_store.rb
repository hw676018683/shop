class AddToStore < ActiveRecord::Migration
  def change
    add_column :stores, :background, :string
    add_column :stores, :slogan, :string
  end
end
