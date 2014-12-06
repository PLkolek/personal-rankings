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
    @post = PostForm.new(post_form_params)
    if @post.valid? and create_post
      redirect_to admin_posts_url, notice: 'Post was successfully created.'
    else
      render_errors :new
    end
  end

  def update
    @post = PostForm.new(post_form_params)
    if @post.valid? and update_post
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
  def create_post
    post = Post.new(title: @post.title, content: @post.content, position: @post.position, category_id: @post.category_id)
    post.user = current_user
    post.save
  end

  def update_post
    post = Post.find(params[:id])
    post.update(title: @post.title, content: @post.content, position: @post.position, category_id: @post.category_id)
  end

  def render_errors action
    set_main_ranking
    set_categories
    render action
  end

  def set_categories
    @categories = Category.all
  end

  def post_form_params
    params.require(:post_form).permit(:title, :content, :category_id, :position)
  end

  def set_main_ranking
    @main_ranking = RankingPresenter.new('Mój ranking', Post.where(user: current_user).order(:rank))
  end
end
