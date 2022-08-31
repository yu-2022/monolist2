class Item < ApplicationRecord
  belongs_to :user
  belongs_to :list
  has_many :tag_items, dependent: :destroy
  has_many :tags,     through: :tag_items
  has_one_attached :image

  validates :item_name, presence: true, length: { maximum: 40 }
  validates :user,      presence: true
  validates :list,      presence: true

  def save_tag(sent_tags)
    TagItem.where(item_id: self.id).destroy_all unless self.tags.nil?
    sent_tags.each do |sent|
      sent_item_tag = Tag.find_or_create_by(tag_name: sent)
      self.tags << sent_item_tag
    end
  end
end
