class GamesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def show
    @game = Game.find_by_name(params[:name])
  end

  def to_param
    name
  end

  private

  def game_params
    params.require(:game).permit(:name)
  end
end
