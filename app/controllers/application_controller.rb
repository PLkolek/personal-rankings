class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_main_ranking, :set_category_rankings

private
  def set_category_rankings
    @category_rankings = Category.all.map {|c| RankingPresenter.new(c.name, c.posts)}
  end
  def set_main_ranking
    @main_ranking = RankingPresenter.new('Wszystko na raz', Post.order(:rank))
  end
end
