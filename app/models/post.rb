class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :category
  validates :category, presence: true
  validates :title, presence: true
  validates :content, presence: true
end
