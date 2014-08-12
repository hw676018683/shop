class Product < ActiveRecord::Base
  belongs_to :store

  has_many :details
  has_many :skulists
  has_many :properties

  belongs_to :category
end
