class CreateDataProviders < ActiveRecord::Migration
  def change
    create_table :data_providers do |t|
      t.string :name
      t.string :root_url
      t.references :sanctioning_body

      t.timestamps
    end
    add_index :data_providers, :sanctioning_body_id
  end
end
