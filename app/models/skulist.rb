class Skulist < ActiveRecord::Base

  belongs_to :skucate, touch: true
end
