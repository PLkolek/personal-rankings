class Admin::PostsController < Admin::AdminController
  before_action :authenticate_user!
  respond_to :html

  def index
    @posts = Post.where(user: current_user)
    respond_with(@posts)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = PostForm.new
    set_main_ranking
    set_categories
  end

  def edit
    @post = PostForm.fromPost(Post.find(params[:id]))
    set_main_ranking
    set_categories
  end

  def create
    create_post_form
    if save_post.call @post
      redirect_to admin_posts_url, notice: 'Post was successfully created.'
    else
      render_errors :new
    end
  end

  def update
    create_post_form
    if save_post.call @post
      redirect_to admin_posts_url, notice: 'Post was successfully updated.'
    else
      render_errors :edit
    end
  end

  def destroy
    Post.find(params[:id]).destroy
    redirect_to admin_posts_url, notice: 'Post was successfully destroyed.'
  end

private
   def render_errors action
    set_main_ranking
    set_categories
    render action
  end

  def set_categories
    @categories = Category.all
  end

  def post_form_params
    params.require(:create_post_form).permit(:title, :content, :category_id, :position)
  end

  def set_main_ranking
    @main_ranking = RankingPresenter.new('Mój ranking', Post.where(user: current_user).order(:rank))
  end

  def save_post
    @save_post ||= SavePost.new
  end

  def create_post_form
    @post = PostForm.new(post_form_params)
    @post.user_id=current_user.id
  end
end
