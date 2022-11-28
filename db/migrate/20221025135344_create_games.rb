class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.string :name
      t.integer :duration
      t.text :description
      t.references :category, null: false, foreign_key: true
      t.text :solution

      t.timestamps
    end
  end
end
