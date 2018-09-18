class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :age
      t.date :date_of_birth
      t.string :social_security_number
      t.string :ethnicity
      t.float :salary
      t.integer :years_experience
      t.string :access
      t.string :password

      t.timestamps
    end
  end
end
