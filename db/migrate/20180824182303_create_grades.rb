class CreateGrades < ActiveRecord::Migration[5.2]
  def change
    create_table :grades do |t|
      t.integer :user_id
      t.integer :assignment_id
      t.integer :grade

      t.timestamps
    end
  end
end
