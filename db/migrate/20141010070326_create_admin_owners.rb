class CreateAdminOwners < ActiveRecord::Migration
  def change
    create_table :admin_owners do |t|
      t.string :email
      t.integer :phone
      t.string :password_digest
      t.string :remember_token

      t.timestamps
    end
  end
end
