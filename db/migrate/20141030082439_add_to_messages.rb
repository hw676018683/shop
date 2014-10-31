class AddToMessages < ActiveRecord::Migration
  def change
    remove_column :messages, :status
    add_column :messages, :status, :boolean, default: false
  end
end
