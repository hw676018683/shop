json.array! @products do |product|
  json.(product, :id, :name, :price)
  json.picture image_path product.main_img
end