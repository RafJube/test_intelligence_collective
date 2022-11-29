class UserGamesController < ApplicationController
  def index
    @user_games = UserGame.where(user_id: current_user)
    @categories = []
    @user_games.each do |user_game|
      @categories.include?(user_game.category) ? @categories : @categories << user_game.category
    end
  end

  def show
    @user_game = UserGame.find(params[:id])
    @game = Game.find(@user_game.game_id)
    if @user_game.answer
      global_answer = JSON.parse @user_game.answer
      @answers = global_answer["answers"]
    end
    case @game.name.downcase
    when "lecture dans les yeux", "lecture dans les yeux - le retour"
      @raw_score = @user_game.lecture_yeux_good_answers
    when "pacman"
      @pacman = @user_game.pacman
    end
  end

  def new
    @game = Game.find_by_name(params[:game_name])
    @user_game = UserGame.new
  end

  def create
    @user_game = UserGame.new(user_game_params)
    @user_game.user = current_user
    @user_game.completed = true
    @game = Game.find_by_name(params[:game_name])
    @user_game.game = @game
    case @game.name.downcase
    when "liste de mots"
      @user_game.answer = @user_game.words_list_validation
      @user_game.score = @user_game.words_list_score
    when "test de la nasa"
      @user_game.answer = @user_game.nasa_validation
      @user_game.score = @user_game.nasa_score
    when "lecture dans les yeux", 'lecture dans les yeux - le retour'
      @user_game.answer = @user_game.lecture_yeux_validation
      @user_game.score = @user_game.lecture_yeux_score
    end
    if @user_game.save
      redirect_to game_user_game_path(@game.name, @user_game)
    else
      render :new
    end
  end

  private

  def user_game_params
    params.require(:user_game).permit(:completed, :answer, :score, :user_id, :game_name)
  end
end
