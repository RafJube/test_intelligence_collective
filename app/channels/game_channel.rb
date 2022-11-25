class GameChannel < ApplicationCable::Channel
  def subscribed
    game = Game.find(params[:id])
    stream_for game
    game.users_connected += 1
    game.ongoing = true if game.users_connected == game.players_number
    game.save
    GameChannel.broadcast_to(
      game,
      {
        connected: game.users_connected
      }
    )
  end

  def unsubscribed
    game = Game.find(params[:id])
    game.users_connected -= 1
    game.ongoing = false if game.users_connected != game.players_number
    game.save
    GameChannel.broadcast_to(
      game,
      {
        connected: game.users_connected
      }
    )
  end
end
