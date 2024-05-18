class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :nickname
      t.text :comment
      t.references :group, foreign_key: true

      t.timestamps
    end
  end
end