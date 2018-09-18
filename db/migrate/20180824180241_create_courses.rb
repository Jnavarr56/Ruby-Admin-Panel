class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :course_title
      t.string :course_description

      t.timestamps
    end
  end
end
