class AddFieldsToPackages < ActiveRecord::Migration[8.1]
  def change
    add_column :packages, :includes, :text
    add_column :packages, :ideal_for, :string
    add_column :packages, :cta_text, :string
    add_column :packages, :cta_url, :string
    add_column :packages, :badge_text, :string
    add_column :packages, :category, :string
  end
end
