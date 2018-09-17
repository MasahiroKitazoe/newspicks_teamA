module ApplicationHelper
  def resource_name
      :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def resource_class
    devise_mapping.to
  end

  def calc_time(obj)
    before_time = Time.now() - obj.created_at
    if before_time < 60
      p before_time.round.to_s + "秒前"
    elsif before_time < 60 * 60
      p (before_time/60).round.to_s + "分前"
    elsif before_time < 60 * 60 *24
      p (before_time/60/60).round.to_s + "時間前"
    else
      p obj.created_at.strftime("%Y年%m月%d日")
    end
  end

  def notification_by_user(notification)
    user_id = notification.notified_by_id
    user = User.find(user_id)
    return user
  end

  def notification_at_comment(notification)
    comment_id = notification.comment_id
    comment = Comment.find(comment_id)
    return comment
  end

  def user_notifications(user)
    if user_signed_in?
      @notifications = user.notifications
      return @notifications.order("id DESC")
    end
  end
end
