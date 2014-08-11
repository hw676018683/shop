class Product < ActiveRecord::Base
  has_many :details
  has_many :skulists
  has_many :properties

  belongs_to :category
end
