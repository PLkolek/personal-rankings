class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :category
  belongs_to :user

  def position
    Post.where('rank <= ?', self.rank).count
  end
end
