class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.integer :players_number, null: false, default: 2
      t.integer :time_refresh, null: false, default: 10
      t.integer :grid_size, null: false, default: 10
      t.integer :ghosts_number, null: false, default: 10
      t.integer :hit_count, default: 0
      t.integer :total_time
      t.boolean :completed, default: false
      t.boolean :ongoing, default: false
      t.integer :game_code
      t.integer :target_position, default: 1
      t.string :ghosts_position
      t.string :pending_actions
      t.integer :users_connected, default: 0

      t.timestamps
    end
  end
end
