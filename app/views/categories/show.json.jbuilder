json.cache! [:products, @products.collect(&:updated_at).max] do
  json.array! @products do |product|
    json.(product, :id, :name)
    json.picture_url image_path(product.main_img)
  end
end


