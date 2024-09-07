class CreateProfiles < ActiveRecord::Migration[7.2]
  def change
    create_table :profiles do |t|
      t.string :access_key
      t.string :secret_key

      t.timestamps
    end
  end
end
