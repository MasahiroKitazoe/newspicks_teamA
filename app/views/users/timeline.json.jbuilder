json.array! @my_comments do |comment|
  if comment.keyword
    json.keyword comment.keyword
  end
  json.user_image comment.user.image.url
  json.user_last_name comment.user.last_name
  json.user_first_name comment.user.first_name
  json.created_at comment.created_at
  json.comment comment.comment
  json.pick_title comment.pick.title
end
