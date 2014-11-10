class Admin::CategoriesController < ApplicationController
  def index
    @categories=Category.all
  end

  def destroy
  end

  def update
  end

  def create
  end
end
