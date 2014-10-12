class Product < ActiveRecord::Base
  belongs_to :store

  has_many :details
  has_many :skucates
  has_many :properties
  has_many :imglists

  belongs_to :category

  validates :name, presence: true
  validates :category_id, presence: true
end
