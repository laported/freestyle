class CreateRaces < ActiveRecord::Migration
  def change
    create_table :races do |t|
      t.string :stroke
      t.integer :distance
      t.float :time
      t.float :points
      t.integer :place
      t.string :standard_achieved
      t.references :swimmer
      t.references :sanctioning_body
      t.references :meet

      t.timestamps
    end
    add_index :races, :swimmer_id
    add_index :races, :sanctioning_body_id
    add_index :races, :meet_id
  end
end
