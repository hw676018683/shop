class Item < ActiveRecord::Base
  belongs_to :user
  belongs_to :skucate

  validates :skucate_id, presence: true
  validates :quantity, presence: true
 
end
