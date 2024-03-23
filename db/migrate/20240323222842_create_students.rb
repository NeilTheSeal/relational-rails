class CreateStudents < ActiveRecord::Migration[7.1]
  def change
    create_table :students do |t|
      t.string :name
      t.integer :age
      t.decimal :account_balance
      t.boolean :currently_enrolled

      t.timestamps
    end
  end
end
