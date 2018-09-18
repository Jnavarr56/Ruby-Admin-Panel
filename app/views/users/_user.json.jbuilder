json.extract! user, :id, :first_name, :last_name, :email, :age, :date_of_birth, :social_security_number, :ethnicity, :salary, :years_experience, :access, :password, :created_at, :updated_at
json.url user_url(user, format: :json)
