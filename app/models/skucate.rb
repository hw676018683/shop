class Skucate < ActiveRecord::Base
  belongs_to :product, touch: true
  
  has_many :items, dependent: :destroy

  validate :at_least_one_skucate
  validates :price, presence: true
  validates :quantity, presence: true

  def at_least_one_skucate
    case [self.name1, self.name2, self.value1, self.value2].reject(&:blank?).size
    when 0
      errors[:base] << "Please enter at least one skucate"
    when 1
      errors[:base] << "Please enter one complete skucate"
    when 2
      if !((self.name1.blank? & self.value1.blank?) | (self.name2.blank? & self.value2.blank?))
        errors[:base] << "Please enter one complete skucate"
      end
    when 3
      errors[:base] << "Please enter one complete skucate"
    end
  end

end
