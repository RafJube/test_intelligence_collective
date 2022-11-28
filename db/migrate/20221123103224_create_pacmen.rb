class CreatePacmen < ActiveRecord::Migration[6.1]
  def change
    create_table :pacmen do |t|
      t.integer :ghosts_number, null: false, default: 10
      t.integer :grid_size, null: false, default: 10
      t.integer :hits_count, default: 0
      t.integer :total_time, default: 0
      t.string :ghosts_position
      t.belongs_to :user_game, index: { unique: true }, foreign_key: true

      t.timestamps
    end
  end
end
