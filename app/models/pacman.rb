class Pacman < ApplicationRecord
  belongs_to :user_game, dependent: :destroy
  has_one :game, through: :user_game

  def random_ghosts
    random = (2...grid_size * grid_size).to_a
    random.sample(ghosts_number)
  end

  def score
    ((((2.00 * grid_size) - 2 + ghosts_number) / hits_count) + (1.00 / total_time)) * 100
  end

  def time_split
    rest = total_time
    hours = rest.divmod(3_600_000)[0]
    rest = rest.divmod(3_600_000)[1]
    minutes = rest.divmod(60_000)[0]
    rest = rest.divmod(60_000)[1]
    seconds = rest.divmod(1000)[0]
    milliseconds = rest.divmod(1000)[1]
    [milliseconds, seconds, minutes, hours]
  end
end
