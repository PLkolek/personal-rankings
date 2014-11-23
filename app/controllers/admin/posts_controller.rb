class Admin::PostsController < Admin::AdminController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @posts = Post.all
    respond_with(@posts)
  end

  def show
    respond_with(@post)
  end

  def new
    @post = Post.new
    set_ranking
    set_categories
    set_posts_count
  end

  def edit
    set_ranking
    set_categories
    set_posts_count
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to admin_posts_url, notice: 'Post was successfully created.'
    else
      set_categories
      set_posts_count
      set_ranking
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to admin_posts_url, notice: 'Post was successfully updated.'
    else
      set_categories
      set_posts_count
      set_ranking
      render :edit
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to admin_posts_url, notice: 'Post was successfully destroyed.' }
    end
  end

  private
  def set_post
    @post = Post.find(params[:id])
  end

  def set_categories
    @categories = Category.all
  end

  def set_posts_count
    @posts_count = Post.count
  end

  def post_params
    params.require(:post).permit(:title, :content, :created_at, :category_id, :position)
  end

  def set_ranking
    @ranking = Post.order(:rank)
  end
end
