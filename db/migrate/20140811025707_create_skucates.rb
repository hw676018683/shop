class CreateSkucates < ActiveRecord::Migration
  def change
    create_table :skucates do |t|
      t.integer :skulist_id
      t.string :name
      t.string :value

      t.timestamps
    end
  end
end
