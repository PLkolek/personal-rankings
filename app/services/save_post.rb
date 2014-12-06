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
                    position: form_object.position,
                    category_id: form_object.category_id,
                    user_id: form_object.user_id)
    post.save
  end

  def update_post form_object
    post = Post.find(params[:id])
    post.update(title: form_object.title,
                content: form_object.content,
                position: form_object.position,
                category_id: form_object.category_id,
                user_id: form_object.user_id)
  end
end