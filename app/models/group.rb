class Group < ApplicationRecord
  has_many :group_customers, dependent: :destroy
  has_many :customers, through: :group_customers, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :membership_requests, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  def send_membership_request(customer)
    membership_requests.create(customer: customer)
  end

  def pending_membership_requests
    membership_requests.where(status: 'pending')
  end
end
