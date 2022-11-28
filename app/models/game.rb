class Game < ApplicationRecord
  belongs_to :category
  has_many :user_games
  has_many :pacmen, through: :user_games
end
