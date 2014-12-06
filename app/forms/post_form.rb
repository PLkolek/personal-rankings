class PostForm
  ValidationError = Class.new(StandardError)

  include Virtus.model
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attribute :id, Integer
  attribute :title, String
  attribute :content, String
  attribute :category_id, Integer
  attribute :position, Integer, :default=>-1

  validates :title, presence: true
  validates :content, presence: true
  validates :category_id, presence: true
  validates :position, presence: true, numericality: {greater_than_or_equal_to: 0}

  def persisted?
    id!=nil
  end

  def self.fromPost post
    PostForm.new(id: post.id,
                 title: post.title,
                 content: post.content,
                 category_id: post.category.id,
                 position: (post.real_position or -1) )
  end

end