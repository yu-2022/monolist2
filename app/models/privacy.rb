class Privacy < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '公開' },
    { id: 3, name: 'フォロワーにのみ公開' },
    { id: 4, name: '非公開' },
  ]

  include ActiveHash::Associations
  has_many :lists
end
