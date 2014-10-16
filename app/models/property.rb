class Property < ActiveRecord::Base
  belongs_to :product, touch: true

  validates :name, presence: true
  validates :value, presence: true
end
