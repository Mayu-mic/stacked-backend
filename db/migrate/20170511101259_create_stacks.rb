class CreateStacks < ActiveRecord::Migration[5.0]
  def change
    create_table :stacks do |t|
      t.references :list, foreign_key: true, null: false
      t.string :title, null: false
      t.text :note, null: false, default: ""
      t.integer :status, null: false, default: 0
      t.integer :star_count, null: false, default: 0
      t.references :created_by, foreign_key: true, null: false

      t.timestamps
    end
  end
end
