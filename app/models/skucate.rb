class Skucate < ActiveRecord::Base
  belongs_to :product, touch: true
  
  has_one :skulist, dependent: :destroy
  has_many :cars
  has_many :nosign_cars
end
