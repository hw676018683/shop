class Property < ActiveRecord::Base
  belongs_to :product

  validates :name, presence: true, uniqueness: true
end
