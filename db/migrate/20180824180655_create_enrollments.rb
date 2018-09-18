class CreateEnrollments < ActiveRecord::Migration[5.2]
  def change
    create_table :enrollments do |t|
      t.integer :section_id
      t.integer :user_id

      t.timestamps
    end
  end
end
