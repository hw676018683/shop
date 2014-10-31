class ChangePhoneUsers < ActiveRecord::Migration
  def change
    remove_column :users, :phone
    add_column :users, :phone, :integer, limit: 5
  end
end
