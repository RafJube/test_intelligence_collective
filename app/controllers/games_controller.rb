class GamesController < ApplicationController
  before_action :test_by_name, only: %i[entercode join new create]

  def index
    @games = Game.joins(:user_games).where(user_games: { user_id: current_user })
  end

  def entercode
    @game = Game.new
    render 'join'
  end

  def join
    @games = Game.where(game_code: game_params[:game_code])
    if @games.empty?
      flash[:notice] = "Désolé mais ce code n'existe pas!"
      redirect_to test_join_game_path(@test.name)
    else
      @game = @games.first
      @test = @game.test
      if @game.save
        @game.create_game_user(current_user)
        redirect_to test_game_path(@test.name, @game)
      else
        flash[:notice] = "Désolé mais un problème est survenu!"
        redirect_to test_join_game_path(@test.name)
      end
    end
  end

  def show
    @game = Game.find(params[:id])
    @test = @game.test
    @connected = @game.users_connected
  end

  def new
    @game = Game.new
  end

  def create
    @user_game = UserGame.new
    @game = Game.new(game_params)
    @game.test = @test
    @game.game_code = code
    @game.ghosts_position = @game.random_ghosts
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
    params.require(:game).permit(:players_number, :grid_size, :ghosts_number, :time_refresh, :game_code, :ongoing)
  end

  def code
    code = ""
    4.times do
      code += (((9 * rand) + 1).floor).to_s
    end
    if Game.last
      Game.last.id.to_s.length > 1 ? code += (Game.last.id + 1).to_s : code += "0#{Game.last.id + 1}"
    else
      code += "01"
    end
    code
  end
end
