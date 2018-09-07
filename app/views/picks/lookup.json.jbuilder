json.array! @picks do |filtered_pick|
  json.id filtered_pick.id
  json.image filtered_pick.image
  json.comments_count filtered_pick.comments.count
  json.title filtered_pick.title
  json.source filtered_pick.source
  json.created_at filtered_pick.created_at
  json.body filtered_pick.body
end

json.array! @comments do |filtered_comment|
  json.id filtered_comment.id
  json.pick_id filtered_comment.pick.id
  json.user_image filtered_comment.user.image.url
  json.user_last_name filtered_comment.user.last_name
  json.user_first_name filtered_comment.user.first_name
  json.user_positon filtered_comment.user.position
  json.created_at filtered_comment.created_at
  json.comment filtered_comment.comment
  json.like_count filtered_comment.likes.count
  json.pick_title filtered_comment.pick.title
  json.pick_source filtered_comment.pick.source
  json.pick_created_at filtered_comment.pick.created_at
end
