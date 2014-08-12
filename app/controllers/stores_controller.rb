class StoresController < ApplicationController

  def index
    @categories = []

    @shop = Store.first
    @shop.products.each do |product|
      category = Category.find(product.category_id)
        if !category.in?(@categories)
          @categories << category
        end
    end
  end
end
