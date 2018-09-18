json.my_comments @my_comments do |comment|
  json.id comment.id
  if comment.keyword
    json.keyword comment.keyword
  end
  json.user_image comment.user.image.url
  json.user_last_name comment.user.last_name
  json.user_first_name comment.user.first_name
  json.created_at calc_time(comment)
  json.comment comment.comment
  json.pick_id comment.pick.id
  json.pick_title comment.pick.title
end

json.latest_comments @latest_comments do |comment|
  json.id comment.id
  if comment.keyword
    json.keyword comment.keyword
  end
  json.user_image comment.user.image.url
  json.user_last_name comment.user.last_name
  json.user_first_name comment.user.first_name
  json.created_at calc_time(comment)
  json.comment comment.comment
  json.pick_id comment.pick.id
  json.pick_title comment.pick.title
end
