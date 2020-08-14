require 'rails_helper'

RSpec.describe "Discs", type: :request do

  describe "GET /index" do
    xit "returns http success" do
      get "/discs/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    xit "returns http success" do
      get "/discs/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    xit "returns http success" do
      get "/discs/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    xit "returns http success" do
      get "/discs/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
