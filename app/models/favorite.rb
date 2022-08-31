class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :list

  validates :user, presence: true
  validates :list, presence: true
  validates_uniqueness_of :list_id, scope: :user_id
end