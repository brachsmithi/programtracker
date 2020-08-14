require 'rails_helper'

RSpec.describe "Series", type: :request do

  describe "GET /index" do
    xit "returns http success" do
      get "/series/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    xit "returns http success" do
      get "/series/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    xit "returns http success" do
      get "/series/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    xit "returns http success" do
      get "/series/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
