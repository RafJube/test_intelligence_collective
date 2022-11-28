module  Admin
  class GamesController < AppAdminController
    before_action :set_game, only: %i[show edit update destroy]
    before_action :set_current_view, only: %i[index new edit]

    def index
      @games = Game.all
    end

    def show
    end

    def new
      @game = Game.new
    end

    def create
      @game = Game.new(game_params)
      if @game.save
        redirect_to admin_games_path
      else
        render :new
      end
    end

    def destroy
      @game.destroy
      redirect_to admin_games_path
    end

    def edit
    end

    def update
      @game.update(game_params)
      if @game.save
        redirect_to admin_games_path
      else
        render :edit
      end
    end

    private

    def set_current_view
      @current_view = 'games'
    end

    def set_game
      @game = Game.find(params[:id])
    end

    def game_params
      params.require(:game).permit(:name, :duration, :description, :solution, :category_id)
    end
  end
end
