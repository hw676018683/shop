json.cache! [@product] do
  json.(@product, :id, :name, :category_id, :price, :quantity)
  json.main_img image_path @product.main_img_url
  json.cache! [:imglists, @product.imglists.collect(&:updated_at).max] do
    json.imglist do
      json.array! @product.imglists.order(:order) do |img|
        json.id img.id
        json.img image_path(img.img)
      end
    end
  end
  json.cache! [:properties, @product.properties.collect(&:updated_at).max] do
    json.property do
      json.array! @product.properties do |property|
        json.(property, :id, :name, :value)
      end
    end
  end
  json.cache! [:details, @product.details.collect(&:updated_at).max] do
    json.detail do
      json.array! @product.details.order(:id) do |detail|
        json.(detail, :id, :text)
        json.img image_path(detail.img)
      end
    end
  end
  json.cache! [:skucates, @product.skucates.collect(&:updated_at).max] do
    json.skucate do
      json.array! @product.skucates.includes(:skulist) do |skucate|
        json.(skucate, :id, :name1, :value1, :name2, :value2)
        json.(skucate.skulist, :price, :oldprice, :quantity)
      end
    end
  end
end
