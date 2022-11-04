module  Admin
  class CategoriesController < AppAdminController
    before_action :set_category, only: %i[show edit update destroy]

    def index
      @categories = Category.all
    end

    def show
    end

    def new
      @category = Category.new
    end

    def create
      @category = Category.new(category_params)
      if @category.save
        redirect_to admin_category_path(@category)
      else
        render :new
      end
    end

    def destroy
      @category.destroy
      redirect_to admin_categories_path
    end

    def edit
    end

    def update
      @category.update(category_params)
      if @category.save
        redirect_to admin_category_path(@category)
      else
        render :edit
      end
    end

    private

    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name)
    end
  end
end
