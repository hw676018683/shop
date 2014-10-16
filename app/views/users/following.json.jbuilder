json.array! @products do |product|
  json.(product, :id, :name, :price)
  json.pictture product.main_img
end