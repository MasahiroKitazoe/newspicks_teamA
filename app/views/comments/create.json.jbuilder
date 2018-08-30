json.comment @comment.comment
json.user_first_name @comment.user.first_name
json.user_company @comment.user.company
json.created_at @comment.created_at.strftime("%Y年%m月%d日 %H時%M分")
json.id         @comment.id
