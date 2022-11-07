module  Admin
  class UsersController < AppAdminController
    before_action :set_user, only: %i[show edit update destroy]
    before_action :set_current_view, only: %i[index new edit]

    def index
      @users = User.all
    end

    def show
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to admin_users_path(@user)
      else
        render :new
      end
    end

    def destroy
      @user.destroy
      redirect_to admin_users_path
    end

    def edit
    end

    def update
      @user.update(user_params)
      if @user.save
        redirect_to admin_users_path(@user)
      else
        render :edit
      end
    end

    private

    def set_current_view
      @current_view = 'users'
    end

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :username, :admin)
    end
  end
end
