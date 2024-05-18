class CreateGroupCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :group_customers do |t|
      t.references :group, foreign_key: true
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
