class CategoriesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find_by_name(params[:name])
    @tests = Test.where(category_id: @category)
  end

  def to_param
    name
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
