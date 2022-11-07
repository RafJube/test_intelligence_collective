module  Admin
  class CategoriesController < AppAdminController
    before_action :set_category, only: %i[show edit update destroy]
    before_action :set_current_view, only: %i[index new edit]

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
        redirect_to admin_categories_path
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
        redirect_to admin_categories_path
      else
        render :edit
      end
    end

    private

    def set_current_view
      @current_view = 'categories'
    end

    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name)
    end
  end
end
