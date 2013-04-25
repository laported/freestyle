class CreateSwimmers < ActiveRecord::Migration
  def change
    create_table :swimmers do |t|
      t.date :dob
      t.string :first
      t.string :last

      t.timestamps
    end
  end
end
