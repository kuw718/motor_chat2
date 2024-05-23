class CreateMembershipRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :membership_requests do |t|
      t.references :group, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.string :status, default: 'pending'

      t.timestamps
    end
  end
end
