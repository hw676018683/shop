class Skucate < ActiveRecord::Base
  belongs_to :product
  
  has_one :skulist
end
