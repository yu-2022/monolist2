require 'rails_helper'

RSpec.describe List, type: :model do
  before do
    @list = FactoryBot.build(:list)
  end

  describe 'リスト登録機能' do
    context 'リストを登録できる場合' do
      it '全ての項目が入力されれば登録できる' do
        expect(@list).to be_valid
      end
      it 'list_textが空でも登録できる' do
        expect(@list).to be_valid
      end
    end

    context 'リストを登録できない場合' do
      it 'list_nameが空では登録できない' do
        @list.list_name = ''
        @list.valid?
        expect(@list.errors.full_messages).to include("List name can't be blank")
      end
      it 'list_nameが41文字以上では登録できない' do
        @list.list_name = 'aaaaabbbbbcccccdddddeeeeefffffggggghhhhh1'
        @list.valid?
        expect(@list.errors.full_messages).to include("List name is too long (maximum is 40 characters)")
      end
      it 'privacy_idが1では登録できない' do
        @list.privacy_id = '1'
        @list.valid?
        expect(@list.errors.full_messages).to include("Privacy can't be blank")
      end
      it 'userが紐付いていないと保存できない' do
        @list.user = nil
        @list.valid?
        expect(@list.errors.full_messages).to include('User must exist')
      end
    end
  end
end
