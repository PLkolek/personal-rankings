class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :category
  validates :category, presence: true
  validates :title, presence: true
  validates :content, presence: true
  validates :position, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0}

  def position
    @position
  end

  def position=(value)
    @position=value
    self.real_position = value
  end

  def real_position
    Post.where("rank <= ?", self.rank).count
  end

  def real_position=(value)
    position = value
    value=value.to_i
    posts=Post.order(:rank)
    if posts.length==0 then
      self.rank=1
    elsif value>= posts.length then
      self.rank=posts.last.rank+1
    elsif value<=0
      self.rank=posts.first.rank-1
    else
      self.rank=(posts[value-1].rank+posts[value].rank)/2.0
    end
  end
end
