class CreateSchools < ActiveRecord::Migration[7.1]
  def change
    create_table :schools do |t|
      t.string :name
      t.string :location
      t.boolean :abet_accredited
      t.integer :student_capacity

      t.timestamps
    end
  end
end
