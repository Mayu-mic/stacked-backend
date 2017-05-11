class CreateLists < ActiveRecord::Migration[5.0]
  def change
    create_table :lists do |t|
      t.string :name, null: false
      t.integer :order, null: false
      t.integer :status, null: false, default: 0
      t.references :created_by, foreign_key: true, null: false

      t.timestamps
    end
  end
end
