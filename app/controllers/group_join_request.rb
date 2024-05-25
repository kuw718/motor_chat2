class GroupJoinRequest < ApplicationRecord
  belongs_to :group
  belongs_to :customer
  enum status: { pending: 0, accepted: 1, rejected: 2 }
end