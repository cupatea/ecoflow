class CreateStats < ActiveRecord::Migration[7.2]
  def change
    create_table :stats do |t|
      t.references :device, null: false, foreign_key: true
      t.json :data
      t.boolean :error, default: false, null: false

      t.timestamps
    end
  end
end
