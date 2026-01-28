class CreateClientLogos < ActiveRecord::Migration[8.1]
  def change
    create_table :client_logos do |t|
      t.string :name, null: false
      t.integer :position, null: false, default: 0
      t.boolean :enabled, default: true

      t.timestamps
    end

    add_index :client_logos, :position
  end
end
