class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.references :stack, foreign_key: true, null: false
      t.text :body, null: false
      t.references :created_by, foreign_key: true, null: false
      t.integer :like_count, null: false, default: 0

      t.timestamps
    end
  end
end
