class Product < ActiveRecord::Base
  belongs_to :store, touch: true
  belongs_to :category, touch: true

  has_many :details, dependent: :destroy
  has_many :skucates, dependent: :destroy
  has_many :properties, dependent: :destroy
  has_many :imglists, dependent: :destroy

  has_many :comments, dependent: :destroy
  has_many :messages

  has_many :following_relationships, foreign_key: :followed_id
  has_many :followers, through: :following_relationships, source: :follower

  scope :status_true, -> { where(status: true).order(:id) }

  validates :name, presence: true
  validates :category_id, presence: true

  mount_uploader :main_img, AvatarUploader

  after_create 'send_message(1)'
  
  def send_message code
    case code
    when 1
      self.store.collectors.each do |collector|
        collector.messages.create(code: code, store_id: self.store.id, product_id: self.id)
      end
    when 2
      self.followers.each do |follower|
        follower.messages.create!(code: code, product_id: self.id)
      end
      self.following_relationships.destroy_all
    when 3
      self.followers.each do |follower|
        follower.messages.create!(code: code, product_id: self.id)
      end
    end
  end

  def self.build_product_skucates product_params, json, store_id
    return_hash = {}
    @skucates = []
    price = []
    quantity = []
    @product = Product.new(product_params)
    if @product.invalid?
      return false
    end
    skucates = JSON.parse(json)
    skucates.each do |skucate|
      skucate = Skucate.new(Product.skucate_params(skucate))
      price << skucate.price
      quantity << skucate.quantity
      if skucate.invalid?
        return false
      else
        @skucates << skucate
      end
    end
    @product.store_id = store_id
    @product.price = price.min
    @product.quantity = quantity.sum
    return_hash[:product] = @product
    return_hash[:skucates] = @skucates
    return_hash
  end

  private

  def self.skucate_params skucate
    ActionController::Parameters.new(skucate).permit(:name1, :value1, :name2, :value2, :price, :quantity)
  end

end
