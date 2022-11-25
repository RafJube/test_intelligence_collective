class Game < ApplicationRecord
  has_many :user_games, dependent: :destroy
  has_many :users, through: :user_games
  belongs_to :test

  validates :players_number, presence: true

  def create_game_user(user)
    UserGame.create!(game: self, user: user)
  end

  def random_ghosts
    random = (1...grid_size * grid_size).to_a
    random.delete(target_position)
    random.sample(ghosts_number)
  end

  def clock(delay)
    loop do
      sleep delay
    end
  end
end
