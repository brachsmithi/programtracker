require 'rails_helper'

RSpec.describe "Packages", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/packages"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/packages/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      package = create(:package)
      get "/packages/#{package.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      package = create(:package)
      get "/packages/#{package.id}/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "returns http redirect" do
      post "/packages", params: { package: { name: 'Prophecy 5 Disc Set' } }
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "PATCH /update" do
    it "returns http redirect" do
      package = create(:package)
      patch "/packages/#{package.id}", params: { package: {id: package.id, name: 'Prophecy 5-Disc Set' } }
      expect(response).to have_http_status(:redirect)
    end
  end

end
