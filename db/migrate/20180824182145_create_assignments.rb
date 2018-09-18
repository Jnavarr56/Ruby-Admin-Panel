class CreateAssignments < ActiveRecord::Migration[5.2]
  def change
    create_table :assignments do |t|
      t.string :assignment_title
      t.string :assignment_descriotion
      t.integer :section_id
      t.date :due_date

      t.timestamps
    end
  end
end
