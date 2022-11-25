class AddTestReferenceToGames < ActiveRecord::Migration[6.1]
  def change
    add_reference :games, :test, null: false, foreign_key: true
  end
end
