class CreateCaseStudies < ActiveRecord::Migration[8.1]
  def change
    create_table :case_studies do |t|
      t.integer :position, null: false, default: 0
      t.string :title, null: false
      t.string :category
      t.string :metric_label
      t.string :metric_color, default: 'green'
      t.text :description
      t.string :link_url
      t.boolean :enabled, default: true

      t.timestamps
    end

    add_index :case_studies, :position
  end
end
