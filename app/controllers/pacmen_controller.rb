class PacmenController < ApplicationController
  before_action :game_by_name, only: %i[new create]

  # def index
  #   @pacmen = Pacman.joins(:user_games).where(user_games: { user_id: current_user })
  # end

  def new
    @pacman = Pacman.new
    @pacman.ghosts_position = @pacman.random_ghosts
  end

  def create
    @user_game = UserGame.new
    @user_game.user = current_user
    @user_game.game = @game
    @user_game.completed = true
    @pacman = Pacman.new(pacman_params)
    @pacman.user_game = @user_game
    @user_game.score = @pacman.score
    if @user_game.save && @pacman.save
      redirect_to game_user_game_path(@game.name, @user_game)
    else
      render :new
    end
  end

  private

  def game_by_name
    @game = Game.find_by_name(params[:game_name])
  end

  def pacman_params
    params.require(:pacman).permit(:grid_size, :ghosts_number, :ghosts_position, :total_time, :hits_count)
  end

end
