class CreateSections < ActiveRecord::Migration[5.2]
  def change
    create_table :sections do |t|
      t.date :start_date
      t.date :end_date
      t.string :meeting_scheme
      t.time :meeting_time
      t.float :section_hours
      t.integer :course_id

      t.timestamps
    end
  end
end
