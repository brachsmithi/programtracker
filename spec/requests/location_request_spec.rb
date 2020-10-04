require 'rails_helper'

RSpec.describe "Locations", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/locations"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      loc = create(:location)
      get "/locations/#{loc.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/locations/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      loc = create(:location)
      get "/locations/#{loc.id}/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "returns http redirect" do
      post "/locations", params: { location: { name: 'By the TV' } }
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "PATCH /update" do
    it "returns http redirect" do
      loc = create(:location)
      patch "/locations/#{loc.id}", params: { location: {id: loc.id, name: 'Under the bookshelf' } }
      expect(response).to have_http_status(:redirect)
    end
  end

end
