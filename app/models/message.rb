class Message < ActiveRecord::Base

  belongs_to :user
  belongs_to :store
  belongs_to :product
  belongs_to :owner
  belongs_to :reply

  scope :ordered, -> { order(created_at: :desc) }

end
