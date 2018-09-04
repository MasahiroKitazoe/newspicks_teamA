json.array! @filtered_picks do |filtered_pick|
  json.id filtered_pick.id
  json.image filtered_pick.image.url
  json.comments_count filtered_pick.comments.count
  json.title filtered_pick.title
  json.source filtered_pick.source
  json.created_at filtered_pick.created_at
  json.body filtered_pick.body
end
