class CreatePostImages < ActiveRecord::Migration[6.1]
  def change
    create_table :post_images do |t|
      t.string :title
      t.text :caption
      t.integer :customer_id
      t.timestamps
    end
  end
end
