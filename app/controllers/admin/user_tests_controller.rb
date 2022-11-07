module  Admin
  class UserTestsController < AppAdminController
    before_action :set_user_test, only: %i[show edit update destroy]
    before_action :set_current_view, only: %i[index new edit]

    def index
      @user_tests = UserTest.all
    end

    def show
    end

    def new
      @user_test = UserTest.new
    end

    def create
      @user_test = UserTest.new(user_test_params)
      if @user_test.save
        redirect_to admin_user_tests_path(@user_test)
      else
        render :new
      end
    end

    def destroy
      @user_test.destroy
      redirect_to admin_user_tests_path
    end

    def edit
    end

    def update
      @user_test.update(user_test_params)
      if @user_test.save
        redirect_to admin_user_tests_path(@user_test)
      else
        render :edit
      end
    end

    private

    def set_current_view
      @current_view = 'user tests'
    end

    def set_user_test
      @user_test = UserTest.find(params[:id])
    end

    def user_test_params
      params.require(:user_test).permit(:user_id, :test_id, :completed, :answer, :score)
    end
  end
end
