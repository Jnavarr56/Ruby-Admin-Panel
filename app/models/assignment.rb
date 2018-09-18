class Assignment < ApplicationRecord
    belongs_to :section 

    has_many :grades, dependent: :destroy
    has_many :users, through: :grades
end
