require 'rails_helper'

RSpec.describe "Programs", type: :request do

  describe "GET /index" do
    xit "returns http success" do
      get "/programs/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    xit "returns http success" do
      get "/programs/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    xit "returns http success" do
      get "/programs/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    xit "returns http success" do
      get "/programs/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
