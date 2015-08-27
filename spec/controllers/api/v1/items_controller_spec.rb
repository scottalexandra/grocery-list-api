require 'spec_helper'

RSpec.describe Api::V1::ItemsController, type: :controller do
  let(:list) { create(:list) }
  let(:item) { create(:item) }

  describe 'get index' do
    it 'returns the items for a list' do
      list = create(:list)
      item = create(:item)
      list.items << item

      get :index, id: list.id
      items = JSON.parse(response.body)['items']

      expect(response.status).to eq(200)
      expect(items.first['description']).to eq('Apples')
    end
  end

  describe 'get show' do
    it 'returns an item from a list' do
      get :show, id: item.id

      item = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(item['description']).to eq('Apples')
    end
  end

  describe 'post create' do
    it 'creates an item' do
      list = create(:list)

      expect(list.items.count).to eq(0)

      post :create, item: { description: 'Oranges', list_id: list.id }

      expect(response.status).to eq(200)
      expect(list.items.count).to eq(1)
    end
  end

  describe 'put update' do
    it 'updates an item' do
      put :update, id: item.id, item: { description: 'String Cheese' }

      expect(response.status).to eq(200)

      get :show, id: item.id
      item = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(item['description']).to eq('String Cheese')
    end
  end

  describe 'delete destroy' do
    it 'deletes an item' do
      expect(Item.count).to eq(0)
      item = create(:item)

      delete :destroy, id: item.id
      expect(Item.count).to eq(0)
    end
  end
end
