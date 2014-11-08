class Admin::CommentsController < ApplicationController
  before_action :authenticate_user!
  def destroy
    @comment = Comment.find (params[:id])
    @comment.destroy
    redirect_to admin_post_path(@comment.post)
  end
end
