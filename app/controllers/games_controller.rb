class GamesController < ApplicationController
  before_action :test_by_name, only: %i[entercode join new create]

  def index
    @games = Game.joins(:user_games).where(user_games: { user_id: current_user })
  end

  def show
    @game = Game.find(params[:id])
    @test = @game.test
  end

  def new
    @game = Game.new
    @game.ghosts_position = @game.random_ghosts
    @game.test = @test
  end

  def create
    @user_game = UserGame.new
    @game = Game.new(game_params)
    @game.test = @test
    @game.completed = true
    if @game.save
      @game.create_game_user(current_user)
      redirect_to test_game_path(@test.name, @game)
    else
      render :new
    end
  end

  private

  def test_by_name
    @test = Test.find_by_name(params[:test_name])
  end

  def game_params
    params.require(:game).permit(:grid_size, :ghosts_number, :ghosts_position, :total_time, :hit_count)
  end

end
