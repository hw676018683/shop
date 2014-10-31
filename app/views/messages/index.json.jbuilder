json.cache! [:message, @messages.collect(&:updated_at).max] do 
  json.array! @messages do |message|
    case message.code
    when 1
      json.(message, :id, :code, :status, :store_id)
      json.store_name message.store.name
      json.product_id message.product_id
      json.product_name message.product.name
    when 2
      json.(message, :id, :code, :status, :product_id)
      json.product_name message.product.name
    when 3
      json.(message, :id, :code, :status, :product_id)
      json.product_name message.product.name
    when 4
      json.(message, :id, :code, :status, :product_id,)
      json.product_name message.product.name
      json.reply_id message.reply.id
      json.content message.reply.content
    end
  end
end