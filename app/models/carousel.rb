class Carousel < ActiveRecord::Base
  belongs_to :store, touch: true
end
