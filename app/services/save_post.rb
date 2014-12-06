class SavePost
  def call(form_object)
    if form_object.valid?
      ActiveRecord::Base.transaction do
        if form_object.persisted?
          update_post form_object
        else
          create_post form_object
        end
      end
    else
      false
    end
  end
private
  def create_post form_object
    post = Post.new(title: form_object.title,
                    content: form_object.content,
                    category_id: form_object.category_id,
                    user_id: form_object.user_id,
                    rank: post_rank(form_object.position))
    post.save
  end

  def update_post form_object
    post = Post.find(form_object.id)
    post.update(title: form_object.title,
                content: form_object.content,
                category_id: form_object.category_id,
                user_id: form_object.user_id,
                rank: post_rank(form_object.position))
  end

  def post_rank position
    posts=Post.order(:rank)
    if posts.length==0 then
      1
    elsif position>= posts.length then
      posts.last.rank+1
    elsif position<=0
      posts.first.rank-1
    else
      (posts[position-1].rank+posts[position].rank)/2.0
    end
  end
end