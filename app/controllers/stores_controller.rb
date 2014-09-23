class StoresController < ApplicationController

  def index
    if current_user.nil?
      nobaby_sign
    end

    @categories = []
    @store = Store.first
    @store.products.each do |product|
      category = Category.find(product.category_id)
        if !category.in?(@categories)
          @categories << category
        end
    end
  end
end
