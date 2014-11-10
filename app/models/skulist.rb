class Skulist < ActiveRecord::Base

  belongs_to :skucate, touch: true

  validates :price, presence: true
  validates :quantity, presence: true

end
