class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.integer :grid_size, null: false, default: 10
      t.integer :ghosts_number, null: false, default: 10
      t.integer :hit_count, default: 0
      t.integer :total_time, default: 0
      t.boolean :completed, default: false
      t.integer :target_position, default: 1
      t.string :ghosts_position

      t.timestamps
    end
  end
end
