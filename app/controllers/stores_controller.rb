class StoresController < ApplicationController

  def index
    @store = Store.find_by(id: 1)
    @categories = @store.categories.order(:id)
    render 'index.json.jbuilder'
  end
end
