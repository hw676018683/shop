class Property < ActiveRecord::Base
  belongs_to :product, touch: true

  validates :name, presence: true
  validates :value, presence: true

  def self.build_by_json json
    @properties = []
    properties = JSON.parse(json)
    properties.each do |property|
      property = Property.new(Property.property_params(property))
      if property.invalid?
        return false 
      else 
        @properties << property
      end 
    end
    @properties
  end

  private

  def self.property_params property
    ActionController::Parameters.new(property).permit(:name, :value)
  end

end
