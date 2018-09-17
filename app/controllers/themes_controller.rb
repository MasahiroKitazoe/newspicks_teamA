class ThemesController < ApplicationController

  def technology
    @popular = get_popular(8)
    @top = @popular[0]
    @popular = @popular.drop(1)
    @newests = get_newests(8)
    @theme = Theme.find(8)
  end

  def business
    @popular = get_popular(1)
    @top = @popular[0]
    @popular = @popular.drop(1)
    @newests = get_newests(1)
    @theme = Theme.find(1)
  end

  def politics_economics
    @popular = get_popular(6)
    @top = @popular[0]
    @popular = @popular.drop(1)
    @newests = get_newests(6)
    @theme = Theme.find(6)
  end

  def finance
    @popular = get_popular(3)
    @top = @popular[0]
    @popular = @popular.drop(1)
    @newests = get_newests(3)
    @theme = Theme.find(3)
  end

  def carrier_education
    @popular = get_popular(2)
    @top = @popular[0]
    @popular = @popular.drop(1)
    @newests = get_newests(2)
    @theme = Theme.find(2)
  end

  def society_sports
    @popular = get_popular(7)
    @top = @popular[0]
    @popular = @popular.drop(1)
    @newests = get_newests(7)
    @theme = Theme.find(7)
  end

  def innovation
    @popular = get_popular(4)
    @top = @popular[0]
    @popular = @popular.drop(1)
    @newests = get_newests(4)
    @theme = Theme.find(4)
  end

  def joboffer
    @popular = get_popular(5)
    @top = @popular[0]
    @popular = @popular.drop(1)
    @newests = get_newests(5)
    @theme = Theme.find(5)
  end

    private
    def get_popular(theme_id)
      theme = Theme.find(theme_id)
      picks = theme.picks
      ids = Comment.group(:pick_id).order('count_pick_id DESC').limit(15).count(:pick_id).keys
      if picks.length != 0
        target_ids = ids & picks.ids
        ranking =  target_ids.map { |id| picks.find(id) }
        ranking.length == 0 ? picks.order('created_at DESC').limit(15) : ranking
      else
        ranking =  ids.map { |id| Pick.find(id) }
        ranking.length == 0 ? Pick.order('created_at DESC').limit(15) : ranking
      end
    end

    def get_newests(theme_id)
      picks = Theme.find(theme_id).picks
      newests = picks.order('created_at DESC').limit(18)
      if newests.length == 0
        Pick.order('created_at DESC').limit(18)
      else
        newests
      end
    end
end
