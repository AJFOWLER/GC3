class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.integer :age
      t.float :weight
      t.float :height
      t.float :creatinine
      t.float :crcl
      t.text :gender
      t.float :crcl
      t.float :ibw
      t.float :bmi
      t.float :ddw
      t.integer :dose

      t.timestamps null: false
    end
  end
end
