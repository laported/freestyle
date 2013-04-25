class CreateSwimmerIdKeys < ActiveRecord::Migration
  def change
    create_table :swimmer_id_keys do |t|
      t.integer :swimmer_id
      t.integer :data_provider_id
      t.string :key

      t.timestamps
    end
  end
end
