class Add1 < ActiveRecord::Migration
  def change
    add_column :details, :text, :text
  end
end
