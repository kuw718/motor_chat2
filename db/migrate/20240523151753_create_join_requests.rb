class CreateJoinRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :join_requests do |t|
      t.references :group, foreign_key: true
      t.references :customer, foreign_key: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
