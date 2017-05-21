class CreateCommentStars < ActiveRecord::Migration[5.0]
  def change
    create_table :comment_stars do |t|
      t.references :comment, foreign_key: true, null: false
      t.references :created_by, foreign_key: true, null: false

      t.timestamps
    end
    add_index :comment_stars, [:comment_id, :created_by_id], unique: true
  end
end
