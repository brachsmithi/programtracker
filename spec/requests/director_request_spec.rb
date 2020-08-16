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
      create(:default_director)
      get "/directors/1"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http redirect" do
      get "/directors/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "returns http redirect" do
      post "/directors", params: { director: { name: "Any Name" } }
      expect(response).to have_http_status(:redirect)
    end
  end

end
