class Admin::CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def edit
  end

  def new
    @category = Category.new
  end

  def destroy
  end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_url, notice: 'Category was successfully updated.'
    else
      render :edit
    end
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_url, notice: 'Category was successfully created.'
    else
      render :new
    end
  end
private
  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category=Category.find(params[:id])
  end
end
