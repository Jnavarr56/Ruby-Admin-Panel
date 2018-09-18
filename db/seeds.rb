require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#CREATE COURSES
Course.create(course_title: 'Fundamentals of Pastry Preparation', course_description: "100")
Course.create(course_title: 'Cake Decoration Methods', course_description: '100')
Course.create(course_title: 'Desserts of the World', course_description: '200')
Course.create(course_title: 'Basic Bakery Management', course_description: '100')
Course.create(course_title: 'Higher Level Expression', course_description: '400')
Course.create(course_title: 'Menu Pairing', course_description: '300')
Course.create(course_title: 'Chocolate Techniques', course_description: '200')
Course.create(course_title: 'Desert Safety', course_description: '200')
Course.create(course_title: 'Master Baker Exam Prep', course_description: '400')


#CREATE EVENING/MORNING SECTIONS FOR EACH COURSE
Course.all.each do |course|
    Section.create(start_date: Date.parse('3rd September 2018'),  end_date: Date.parse('14th December 2018'), meeting_scheme: 'MWF', meeting_time: '12:00', section_hours: 2, course_id: course[:id])
    Section.create(start_date: Date.parse('4rd September 2018'),  end_date: Date.parse('13th December 2018'), meeting_scheme: 'TTh', meeting_time: '4:00', section_hours: 3, course_id: course[:id])
end

#GO THROUGH EACH COURSE AND CREATE AN INSTRUCTOR, GO THROUGH SECTIONS OF EACH COURSE 
#AND CREATE AN ENROLLMENT FOR SAID INSTRUCTOR IN EACH
Course.all.each do |course|
    ethnicity_generated = Faker::Demographic.race
    first_name_generated = Faker::Name.first_name
    last_name_generated = Faker::Name.last_name
    age_generated = rand(18...32)
    ss_number_generated = Faker::IDNumber.valid
    salary_generated = rand(60000...100000)
    years_experience_generated = 0 
    date_of_birth_generated = Faker::Date.birthday(age_generated, age_generated)
    if salary_generated >= 60000 &&  salary_generated < 70000
        years_experience_generated = rand(1...3)
    elsif salary_generated >= 70000 &&  salary_generated < 80000
        years_experience_generated = rand(4...5)
    else
        years_experience_generated = rand(6...10)
    end
    email_generated = Faker::Internet.email(first_name_generated)
    while User.find_by social_security_number: ss_number_generated != nil
        ss_number_generated = Faker::IDNumber.valid
    end
    while User.find_by email: email_generated  != nil
        email_generated = Faker::Internet.email(first_name_generated)
    end
    User.create(first_name: first_name_generated, last_name: last_name_generated, email: email_generated, age: age_generated, date_of_birth: date_of_birth_generated, social_security_number: ss_number_generated, ethnicity: ethnicity_generated, salary: salary_generated, years_experience: years_experience_generated, access: "instructor", password: Faker::Internet.password(8))

    Section.where('course_id = ?', course[:id]).each do |section|
        Enrollment.create(user_id: User.last[:id], section_id: section[:id])
    end
end


#CREATE 319 STUDENTS AND PLACE THEM RANDOMLY IN DIFFERENT SECTIONS
(1...320).each do |n|
    ethnicity_generated = Faker::Demographic.race
    section_id_generated = rand(Section.first[:id]..Section.last[:id])
    first_name_generated = Faker::Name.first_name
    last_name_generated = Faker::Name.last_name
    age_generated = rand(18...36)
    ss_number_generated = Faker::IDNumber.valid
    email_generated = Faker::Internet.email(first_name_generated)
    while User.find_by social_security_number: ss_number_generated != nil
        ss_number_generated = Faker::IDNumber.valid
    end
    while User.find_by email: email_generated  != nil
        email_generated = Faker::Internet.email(first_name_generated)
    end
    User.create(first_name: first_name_generated, last_name: last_name_generated, email: email_generated, age: age_generated, ethnicity: ethnicity_generated, date_of_birth: Faker::Date.birthday(age_generated, age_generated), social_security_number: ss_number_generated, salary:0, years_experience: 0, access: "student", password: Faker::Internet.password(8))
    Enrollment.create(user_id: User.last[:id], section_id: section_id_generated)
end

