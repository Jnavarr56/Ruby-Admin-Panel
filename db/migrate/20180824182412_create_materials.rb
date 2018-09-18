class CreateMaterials < ActiveRecord::Migration[5.2]
  def change
    create_table :materials do |t|
      t.float :material_price
      t.string :material_title
      t.string :material_description

      t.timestamps
    end
  end
end
