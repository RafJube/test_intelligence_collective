class CreateUserTests < ActiveRecord::Migration[6.1]
  def change
    create_table :user_tests do |t|
      t.boolean :completed, default: false
      t.integer :score
      t.text :answer
      t.references :user, null: false, foreign_key: true
      t.references :test, null: false, foreign_key: true

      t.timestamps
    end
  end
end
