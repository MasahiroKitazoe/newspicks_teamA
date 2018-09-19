class ThemesController < ApplicationController

  def technology
    @theme = Theme.find_by(theme: "テクノロジー")
    @popular = get_popular(@theme.id)
    @top = @popular[0]
    @popular = @popular.drop(1)
    @newests = get_newests(@theme.id)
  end

  def business
    @theme = Theme.find_by(theme: "ビジネス")
    @popular = get_popular(@theme.id)
    @top = @popular[0]
    @popular = @popular.drop(1)
    @newests = get_newests(@theme.id)
  end

  def politics_economics
    @theme = Theme.find_by(theme: "政治・経済")
    @popular = get_popular(@theme.id)
    @top = @popular[0]
    @popular = @popular.drop(1)
    @newests = get_newests(@theme.id)
  end

  def finance
    @theme = Theme.find_by(theme: "金融・マーケット")
    @popular = get_popular(@theme.id)
    @top = @popular[0]
    @popular = @popular.drop(1)
    @newests = get_newests(@theme.id)
  end

  def carrier_education
    @theme = Theme.find_by(theme: "キャリア・教育")
    @popular = get_popular(@theme.id)
    @top = @popular[0]
    @popular = @popular.drop(1)
    @newests = get_newests(@theme.id)
  end

  def society_sports
    @theme = Theme.find_by(theme: "社会・スポーツ")
    @popular = get_popular(@theme.id)
    @top = @popular[0]
    @popular = @popular.drop(1)
    @newests = get_newests(@theme.id)
  end

  def innovation
    @theme = Theme.find_by(theme: "イノベーション")
    @popular = get_popular(@theme.id)
    @top = @popular[0]
    @popular = @popular.drop(1)
    @newests = get_newests(@theme.id)
  end

  def joboffer
    @theme = Theme.find_by(theme: "ジョブオファー")
    @popular = get_popular(@theme.id)
    @top = @popular[0]
    @popular = @popular.drop(1)
    @newests = get_newests(@theme.id)
  end

    private
    def get_popular(theme_id)
      theme = Theme.find(theme_id)
      picks = theme.picks
      picks_ids = picks.ids
      ids = Comment.where(pick_id: picks_ids).group(:pick_id).order('count_pick_id DESC').limit(15).order('created_at DESC').count(:pick_id).keys
      if picks.length != 0
        ranking =  ids.map { |id| picks.find(id) }
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
