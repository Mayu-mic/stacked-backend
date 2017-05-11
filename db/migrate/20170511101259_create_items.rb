class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.references :list, foreign_key: true, null: false
      t.string :title, null: false
      t.text :note
      t.string :status, null: false
      t.references :created_by, foreign_key: true, null: false

      t.timestamps
    end
  end
end
