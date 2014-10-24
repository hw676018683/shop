class Category < ActiveRecord::Base
  belongs_to :store, touch: true
  has_many :products
end
