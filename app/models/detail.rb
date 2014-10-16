class Detail < ActiveRecord::Base
  belongs_to :product, touch: true
end

