class Skulist < ActiveRecord::Base
  belongs_to :product

  has_many :skucates
end
