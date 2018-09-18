class Section < ApplicationRecord
    belongs_to :course

    has_many :enrollments, dependent: :destroy
    has_many :users, through: :enrollments

    has_many :assignments, dependent: :destroy
    has_many :grades, through: :assignments

    has_many :section_materials, dependent: :destroy
    has_many :materials, through: :section_materials
end
