class Admin::StoresController < ApplicationController

  before_action :owner_exist?

  def update
    message = {}
    @store = Store.find(params[:id])
    if @store.update_attributes(store_params)
      message[:code] = 'success'
    else
      message[:code] = 'failure'
      message[:error] = @store.errors
    end
    render json: message
  end

  private

  def store_params
    params.permit(:name, :background, :slogan)
  end

end
