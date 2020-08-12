require 'rails_helper'

RSpec.describe "Directors", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/director/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/director/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/director/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/director/create"
      expect(response).to have_http_status(:success)
    end
  end

end
