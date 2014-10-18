class StoresController < ApplicationController

  def index
    @categories = []
    @store = Store.find_by(id: 1)
    @store.products.where(status: true).each do |product|
      category = Category.find(product.category_id)
        if !category.in?(@categories)
          @categories << category
        end
    end
    render 'index.json.jbuilder'
  end
end
