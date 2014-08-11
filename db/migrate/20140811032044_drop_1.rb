class Drop1 < ActiveRecord::Migration
  def change
    remove_column :details, :text
  end
end
