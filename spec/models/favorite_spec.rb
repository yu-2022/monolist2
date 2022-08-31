require 'rails_helper'

RSpec.describe Favorite, type: :model do
  before do
    @favorite = FactoryBot.build(:favorite)
  end

  describe 'お気に入り登録機能' do
    context 'お気に入り登録できる場合' do
      it '全ての項目が存在すれば登録できる' do
        expect(@favorite).to be_valid
      end
    end

    context 'お気に入り登録できない場合' do
      it 'userが紐付いていないと保存できない' do
        @favorite.user = nil
        @favorite.valid?
        expect(@favorite.errors.full_messages).to include('User must exist')
      end
      it 'listが紐付いていないと保存できない' do
        @favorite.list = nil
        @favorite.valid?
        expect(@favorite.errors.full_messages).to include('List must exist')
      end
    end
  end
end
