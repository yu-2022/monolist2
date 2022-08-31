class List < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :privacy
  
  belongs_to :user
  has_many :items,     dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :fav_users, through: :favorites, source: :user

  validates :list_name,  presence: true, length: { maximum: 40 }
  validates :privacy_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :user,       presence: true

  def self.search(search)
    if search != ""
      List.where('list_name LIKE(?)', "%#{search}%")
    end
  end

end
