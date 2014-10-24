class StoresController < ApplicationController

  def index
    @store = Store.find_by(id: 1)
    @categories = @store.categories
    render 'index.json.jbuilder'
  end
end
