class TagItem < ApplicationRecord
  belongs_to :item
  belongs_to :tag

  validates :item, presence: true
  validates :tag,  presence: true
end
