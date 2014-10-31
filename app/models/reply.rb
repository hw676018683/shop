class Reply < ActiveRecord::Base

  belongs_to :comment
  has_many :comments

  has_one :message

  after_create 'send_message(4)'

  def send_message code
    self.comment.user.messages.create(code: code, product_id: self.comment.product_id, reply_id: self.id)
  end
end
