class StoresController < ApplicationController

  def index
    @store = Store.find(1)
    @categories = @store.categories.order(:id)
    render 'index.json.jbuilder'
  end
end
