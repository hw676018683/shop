class Car < ActiveRecord::Base
  belongs_to :user
  belongs_to :skucate
  # validates :value1, presence: true
  # validates :value2, presence: true
end
