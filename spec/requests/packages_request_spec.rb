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

  describe "GET /create" do
    it "returns http redirect" do
      post "/packages", params: { package: { name: 'Prophecy 5 Disc Set' } }
      expect(response).to have_http_status(:redirect)
    end
  end

end
