json.cache! [@store] do
  json.(@store, :id, :name, :background, :slogan)
  json.cache! [:carousels, @store.carousels.collect(&:updated_at).max] do
    json.carousel do
      json.array! @store.carousels do |picture|
        json.picture image_path(picture.picture)
      end
    end
  end
  json.cache! [:categories, @categories.collect(&:updated_at).max] do
    json.category do
      json.array! @categories do |cate|
        json.(cate, :id, :name)
        json.product do
          json.array! cate.products.where(status: true).first(2) do |product|
            json.product_id product.id
            json.picture image_path(product.main_img)
          end
        end
      end
    end
  end
end

