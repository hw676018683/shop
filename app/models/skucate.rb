class Skucate < ActiveRecord::Base
  belongs_to :product
  
  has_one :skulist
  has_many :cars
  has_many :nosign_cars
end
