class Material < ApplicationRecord
    has_many :section_materials, dependent: :destroy
    has_many :sections, through: :section_materials
end
