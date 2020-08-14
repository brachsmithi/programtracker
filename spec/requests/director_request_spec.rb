require 'rails_helper'

RSpec.describe "Directors", type: :request do

  describe "GET /index" do
    xit "returns http success" do
      get "/director/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    xit "returns http success" do
      get "/director/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    xit "returns http success" do
      get "/director/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    xit "returns http success" do
      get "/director/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
