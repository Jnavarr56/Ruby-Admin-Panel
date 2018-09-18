class User < ApplicationRecord
    has_many :enrollments, dependent: :destroy

    has_many :grades, dependent: :destroy
    has_many :assignments, through: :grades
end
