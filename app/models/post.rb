class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :category
  validates :category, presence: true
  validates :title, presence: true
  validates :content, presence: true
  validate :position, presence: true
  validates :position, numericality: { only_integer: true }

  def position
    Post.where("rank <= ?", self.rank).count
  end

  def position=(value)
    value=value.to_i
    posts=Post.order(:rank)
    if value>= posts.length then
      self.rank=posts.last.rank+1
    elsif value<=0
      self.rank=posts.first.rank-1
    else
      self.rank=(posts[value-1].rank+posts[value].rank)/2.0
    end
  end

  def full_name=(name)
    split = name.split(' ', 2)
    self.first_name = split.first
    self.last_name = split.last
  end
end
