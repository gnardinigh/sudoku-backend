class AddStartToPuzzles < ActiveRecord::Migration[5.2]
  def change
    add_column :puzzles, :start, :string
  end
end
