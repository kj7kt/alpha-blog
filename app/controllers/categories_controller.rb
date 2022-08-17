class CategoriesController < ApplicationController

  def show

  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "New category successfully created"
      redirect_to @category
    else
      render 'new'
    end
  end

  def index

  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end