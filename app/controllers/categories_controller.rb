class CategoriesController < ApplicationController
  before_action :require_admin, except: [:index, :show]

  def show
    @category = Category.find(params[:id])
    @articles = @category.articles.page(params[:page]).per(5)
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
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:notice] = "The category is successfully updated"
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def index
    @categories = Category.page(params[:page]).per(5)
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    unless logged_in? && current_user.admin?
      flash[:alert] = " Only admins can perform that action"
      redirect_to categories_path
    end
  end
end