module  Admin
  class TestsController < AppAdminController
    before_action :set_test, only: %i[show edit update destroy]
    before_action :set_current_view, only: %i[index new edit]

    def index
      @tests = Test.all
    end

    def show
    end

    def new
      @test = Test.new
    end

    def create
      @test = Test.new(test_params)
      if @test.save
        redirect_to admin_tests_path
      else
        render :new
      end
    end

    def destroy
      @test.destroy
      redirect_to admin_tests_path
    end

    def edit
    end

    def update
      @test.update(test_params)
      if @test.save
        redirect_to admin_tests_path
      else
        render :edit
      end
    end

    private

    def set_current_view
      @current_view = 'tests'
    end

    def set_test
      @test = Test.find(params[:id])
    end

    def test_params
      params.require(:test).permit(:name, :duration, :desription, :solution, :category_id)
    end
  end
end
