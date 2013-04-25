class CreateMeets < ActiveRecord::Migration
  def change
    create_table :meets do |t|
      t.string :name
      t.date :start
      t.date :end
      t.string :course
      t.string :location

      t.timestamps
    end
  end
end
