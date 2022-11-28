module  Admin
  class UserGamesController < AppAdminController
    before_action :set_user_game, only: %i[show edit update destroy]
    before_action :set_current_view, only: %i[index new edit]

    def index
      @user_games = UserGame.all
    end

    def show
    end

    def new
      @user_game = UserGame.new
    end

    def create
      @user_game = UserGame.new(user_game_params)
      if @user_game.save
        redirect_to admin_user_games_path(@user_game)
      else
        render :new
      end
    end

    def destroy
      @user_game.destroy
      redirect_to admin_user_games_path
    end

    def edit
    end

    def update
      @user_game.update(user_game_params)
      if @user_game.save
        redirect_to admin_user_games_path(@user_game)
      else
        render :edit
      end
    end

    private

    def set_current_view
      @current_view = 'user games'
    end

    def set_user_game
      @user_game = UserGame.find(params[:id])
    end

    def user_game_params
      params.require(:user_game).permit(:user_id, :game_id, :completed, :answer, :score)
    end
  end
end
