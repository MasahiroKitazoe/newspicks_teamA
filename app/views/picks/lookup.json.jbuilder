json.picks @picks do |filtered_pick|
  json.id filtered_pick.id
  json.image filtered_pick.image
  json.comments_count filtered_pick.comments.count
  json.title filtered_pick.title
  json.source filtered_pick.source
  json.created_at calc_time(filtered_pick)
  json.body filtered_pick.body
end

json.comments @comments do |filtered_comment|
  json.id filtered_comment.id
  json.pick_id filtered_comment.pick.id
  json.user_image filtered_comment.user.image.url
  json.user_last_name filtered_comment.user.last_name
  json.user_first_name filtered_comment.user.first_name
  json.user_position filtered_comment.user.position
  json.created_at calc_time(filtered_comment)
  json.comment filtered_comment.comment
  json.like_count filtered_comment.likes.count
  json.pick_title filtered_comment.pick.title
  json.pick_source filtered_comment.pick.source
  json.pick_created_at calc_time(filtered_comment.pick)
  like = Like.find_by(comment_id: filtered_comment.id, user_id: current_user.id)
  if like
    json.liked true
    json.like_id like.id
  else
    json.liked false
  end
end
