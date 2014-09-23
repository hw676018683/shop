class ChangeTableNosignCard < ActiveRecord::Migration
  def change
    change_table :nosign_cars do |t|
      t.remove :nosign_id
      t.string :nosign_id
    end
  end
end
