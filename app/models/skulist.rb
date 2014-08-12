class Skulist < ActiveRecord::Base
  belongs_to :product

  has_one :skucate
end
