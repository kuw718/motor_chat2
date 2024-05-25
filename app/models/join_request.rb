class JoinRequest < ApplicationRecord
  belongs_to :group
  belongs_to :customer

  validates :customer_id, uniqueness: { scope: :group_id }
end

