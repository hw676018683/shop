class CreateCarousels < ActiveRecord::Migration
  def change
    create_table :carousels do |t|
      t.integer :store_id
      t.string :pirture

      t.timestamps
    end
  end
end
