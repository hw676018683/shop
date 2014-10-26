class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.integer :owner_id
      t.integer :comment_id
      t.string :content

      t.timestamps
    end
  end
end
