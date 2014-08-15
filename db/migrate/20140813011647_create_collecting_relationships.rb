class CreateCollectingRelationships < ActiveRecord::Migration
  def change
    create_table :collecting_relationships do |t|
      t.integer :store_id
      t.integer :user_id

      t.timestamps
    end

    add_index :collecting_relationships, [:store_id, :user_id], unique: true
  end
end
