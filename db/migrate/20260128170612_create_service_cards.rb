class CreateServiceCards < ActiveRecord::Migration[8.1]
  def change
    create_table :service_cards do |t|
      t.integer :position, null: false, default: 0
      t.string :title, null: false
      t.text :description
      t.string :link_text
      t.string :link_url
      t.boolean :enabled, default: true
      t.text :svg_code
      t.string :icon_color

      t.timestamps
    end

    add_index :service_cards, :position
  end
end
