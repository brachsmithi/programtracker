require 'rails_helper'

RSpec.describe "Locations", type: :request do

  describe "GET /index" do
    xit "returns http success" do
      get "/locations/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    xit "returns http success" do
      get "/locations/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    xit "returns http success" do
      get "/locations/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    xit "returns http success" do
      get "/locations/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
