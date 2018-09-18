class Course < ApplicationRecord
    has_many :sections, dependent: :destroy
    has_many :enrollments, through: :sections
    has_many :assignments, through: :sections
    has_many :section_materials, through: :sections
end
