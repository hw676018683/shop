json.array! @items do |item|
  json.id item.id
  json.product_id item.skucate.product.id
  json.name item.skucate.product.name
  json.picture_url image_path(item.skucate.product.main_img)
  json.quantity item.quantity
  json.skucate do 
    json.skucate_id item.skucate_id
    json.price item.skucate.skulist.price
    json.oldprice item.skucate.skulist.oldprice
    json.value1 item.skucate.value1
    json.value2 item.skucate.value2
  end

end

