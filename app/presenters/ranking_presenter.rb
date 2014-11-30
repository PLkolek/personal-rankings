# Presenter is probably not a good name.
class RankingPresenter
  attr_reader :title
  attr_reader :items

  def initialize(title, items)
    @title=title
    @items=items
  end
end