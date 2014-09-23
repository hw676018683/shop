json.(@store, :id, :name, :background, :slogan)
json.carousel do
  json.array! @store.carousels do |picture|
    json.picture '/assests/'+picture.picture
  end
end
json.category do
  json.array! @categories do |cate|
    json.(cate, :id, :name)
    json.product do
      json.array! cate.products.first(2) do |product|
        json.product_id product.id
        json.picture '/assets/'+product.main_img
      end
    end
  end
end

