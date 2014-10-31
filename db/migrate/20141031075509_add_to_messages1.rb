class AddToMessages1 < ActiveRecord::Migration
  def change

    add_column :messages, :reply_id, :integer
  end
end
