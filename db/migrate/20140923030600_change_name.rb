class ChangeName < ActiveRecord::Migration
  def change
    rename_column :carousels, :pirture, :picture
  end
end
