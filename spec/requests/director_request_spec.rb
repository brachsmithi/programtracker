require 'rails_helper'

RSpec.describe "Directors", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/directors"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      director = create(:director)
      get "/directors/#{director.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/directors/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      director = create(:director)
      get "/directors/#{director.id}/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "returns http redirect" do
      post "/directors", params: { director: { name: 'Francis Ford Coppola' }, person_aliases_attributes: { "1": {name: 'Francis Coppola'} } }
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "PATCH /update" do
    it "returns http redirect" do
      director = create(:director)
      patch "/directors/#{director.id}", params: { director: { name: 'Francis Ford Coppola' }, person_aliases_attributes: { "232324": {name: 'Francis Coppola'} } }
    end
  end

  describe "DELETE /destory" do
    it "returns http redirect" do
      director = create(:director)
      delete "/directors/#{director.id}"
      expect(response).to have_http_status(:redirect)
    end
  end

end
