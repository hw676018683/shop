class StoresController < ApplicationController

  def index
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
