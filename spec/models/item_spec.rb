require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
    @item.image = fixture_file_upload('app/assets/images/test_image.png')
  end

  describe 'アイテム登録機能' do
    context 'アイテムを登録できる場合' do
      it '全ての項目が入力されれば登録できる' do
        expect(@item).to be_valid
      end
      it 'item_textが空でも登録できる' do
        @item.item_text = ''
        expect(@item).to be_valid
      end
      it 'item_dateが空でも登録できる' do
        @item.item_date = ''
        expect(@item).to be_valid
      end
      it 'imageが空でも登録できる' do
        @item.image = nil
        expect(@item).to be_valid
      end
    end

    context 'アイテムを登録できない場合' do
      it 'item_nameが空では登録できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end
      it 'item_nameが41文字以上では登録できない' do
        @item.item_name = 'aaaaabbbbbcccccdddddeeeeefffffggggghhhhh1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name is too long (maximum is 40 characters)")
      end
      it 'userが紐付いていないと保存できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
      it 'listが紐付いていないと保存できない' do
        @item.list = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('List must exist')
      end
    end
  end
end
