json.(@product, :id, :name, :category_id)
json.imglist do
  json.array! @product.imglists do |img|
    json.img '/assests/'+img.img
  end
end
json.property do
  json.array! @product.properties do |property|
    json.(property, :name, :value)
  end
end
json.detail do
  json.array! @product.details do |detail|
    json.(detail, :text)
    json.img '/assets/'+detail.img
  end
end
json.skucate do
  json.array! @product.skucates do |skucate|
    json.(skucate, :name1, :value1, :name2, :value2)
    json.(skucate.skulist, :price, :oldprice, :quantity)
  end
end


