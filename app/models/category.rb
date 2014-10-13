class Category < ActiveRecord::Base
  belongs_to :store
  has_many :products
end
