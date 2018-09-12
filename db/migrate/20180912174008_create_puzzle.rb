class CreatePuzzle < ActiveRecord::Migration[5.2]
  def change
    create_table :puzzles do |t|
      t.string :difficulty
      t.string :numbers
    end
  end
end
