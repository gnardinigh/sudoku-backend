class CreateScore < ActiveRecord::Migration[5.2]
  def change
    create_table :scores do |t|
      t.integer :points
      t.references :user, foreign_key: true
      t.references :puzzle, foreign_key: true
    end
  end
end
