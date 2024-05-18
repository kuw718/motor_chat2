class Group < ApplicationRecord
    has_many :group_customers, dependent: :destroy
    has_many :customers, through: :group_customers, dependent: :destroy
    has_many :posts, dependent: :destroy
    validates :name, presence: true, uniqueness: true
end