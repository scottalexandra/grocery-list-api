require 'spec_helper'

RSpec.describe Api::V1::ListsController, type: :controller do
  let(:list) { create(:list) }

  describe 'get index' do
    it 'returns a list of lists' do
      create(:list)
      get :index

      lists = JSON.parse(response.body)["lists"]

      expect(response.status).to eq(200)
      expect(lists.first["title"]).to eq("Grocery List")
    end
  end

  describe 'get show' do
    it 'returns a list' do
      get :show, id: list.id
      list = JSON.parse(response.body)["list"]

      expect(response.status).to eq(200)
      expect(list["title"]).to eq("Grocery List")
    end
  end

  describe 'post create' do
    it 'creates a list' do
      expect(List.count).to eq(0)

      post :create, list: { title: "Grocery List II"}

      expect(response.status).to eq(200)
      expect(List.count).to eq(1)
    end
  end

  describe 'put update' do
    it 'updates a list' do
      put :update, id: list.id, list: { title: "New Grocery List" }
      get :show, id: list.id

      list = JSON.parse(response.body)["list"]
      
      expect(response.status).to eq(200)
      expect(list["title"]).to eq("New Grocery List")
    end
  end

  describe 'delete destroy' do
    it 'destroys a list' do
      post :create, list: { title: "Another List" }
      new_list = JSON.parse(response.body)["list"]
      delete :destroy, id: new_list["id"]

      expect(response.status).to eq(200)
      expect(List.count).to eq(0)
    end
  end
end
