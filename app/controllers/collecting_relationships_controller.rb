class CollectingRelationshipsController < ApplicationController
  before_action :signed_in_user

  # def create
  #   @store = Store.find(params[:collecting_relationship][:store_id])
  #   current_user.collect! @store
  #   respond_to do |format|
  #     format.html { redirect_to root_path }
  #     format.js
  #   end
  # end

  # def destroy
  #   @store = CollectingRelationship.find(params[:id]).store
  #   current_user.uncollect! @store
  #   respond_to do |format|
  #     format.html { redirect_to root_path }
  #     format.js
  #   end
  # end
end
