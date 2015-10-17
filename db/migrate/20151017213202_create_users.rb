class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :number
      t.float :long
      t.float :lat

      t.timestamps null: false
    end
  end
end
