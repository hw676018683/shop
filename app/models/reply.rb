class Reply < ActiveRecord::Base

  belongs_to :comment
  has_many :comments

end
