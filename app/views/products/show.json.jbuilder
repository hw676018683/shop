json.cache! [@product] do
  json.(@product, :id, :name, :category_id)
  json.cache! [:imglists, @product.imglists.collect(&:updated_at).max] do
    json.imglist do
      json.array! @product.imglists do |img|
        json.img image_path(img.img)
      end
    end
  end
  json.cache! [:properties, @product.properties.collect(&:updated_at).max] do
    json.property do
      json.array! @product.properties do |property|
        json.(property, :name, :value)
      end
    end
  end
  json.cache! [:details, @product.details.collect(&:updated_at).max] do
    json.detail do
      json.array! @product.details do |detail|
        json.(detail, :id, :text)
        json.img image_path(detail.img)
      end
    end
  end
  json.cache! [:skucates, @product.skucates.collect(&:updated_at).max] do
    json.skucate do
      json.array! @product.skucates do |skucate|
        json.(skucate, :name1, :value1, :name2, :value2)
        json.(skucate.skulist, :price, :oldprice, :quantity)
      end
    end
  end
end
