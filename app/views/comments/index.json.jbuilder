json.array! @comments do |comment|
  json.name comment.user.name
  json.(comment, :content)
  json.time comment.created_at
end