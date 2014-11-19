class Item < ActiveRecord::Base
  belongs_to :user
  belongs_to :skucate

  validates :skucate_id, presence: true
  validates :quantity, presence: true

  def self.new_item params
    skucate = Skucate.find_by(params.permit(:product_id, :value1, :value2))
    if params[:nosign_id].present?
      Item.new(nosign_id: params[:nosign_id], skucate_id: skucate.id, quantity: params[:quantity])   
    else
      user_exist?(params[:remember_token])
      @user.items.build(skucate_id: skucate.id, quantity: params[:quantity])
    end
  end

  def self.find_item params
    if params[:nosign_id].present?
      Item.where(nosign_id: params[:nosign_id]).find(params[:id])
    else
      user_exist?(params[:remember_token])
      Item.where(user_id: @user.id).find(params[:id])
    end
  end

  def self.find_items params
    if params[:nosign_id].present?
      Item.where(nosign_id: params[:nosign_id])
    else
      user_exist?(params[:remember_token])
      Item.where(user_id: @user.id)
    end
  end


  private

  def self.user_exist? remember_token
    @user = User.find_by(remember_token: User.encrypt(remember_token))
    if @user.nil?
      raise Shop::AuthenticationFailed, "Counldn't find the user"
    end
  end
 
end
