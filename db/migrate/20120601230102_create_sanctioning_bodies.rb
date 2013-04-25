class CreateSanctioningBodies < ActiveRecord::Migration
  def change
    create_table :sanctioning_bodies do |t|
      t.string :name

      t.timestamps
    end
  end
end
