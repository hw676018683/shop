json.array! @products do |product|
  json.(product, :id, :name, :category_id)
  json.picture_url image_path(product.main_img)
  json.(product, :price, :quantity)
end
