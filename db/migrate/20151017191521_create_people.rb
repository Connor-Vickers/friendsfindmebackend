class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :number
      t.float :long
      t.float :lat

      t.timestamps null: false
    end
  end
end
