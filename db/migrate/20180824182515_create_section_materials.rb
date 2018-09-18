class CreateSectionMaterials < ActiveRecord::Migration[5.2]
  def change
    create_table :section_materials do |t|
      t.integer :material_id
      t.integer :section_id

      t.timestamps
    end
  end
end
