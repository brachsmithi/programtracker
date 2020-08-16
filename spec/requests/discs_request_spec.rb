require 'rails_helper'

RSpec.describe "Discs", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/discs"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      disc = create(:disc)
      get "/discs/#{disc.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/discs/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      disc = create(:disc)
      get "/discs/#{disc.id}/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "returns http redirect" do
      loc = create(:default_location)
      post "/discs", params: { disc: { format: Disc::FORMATS.first, state: Disc::STATES.first, location_id: loc.id } }
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "PATCH /update" do
    it "returns http redirect" do
      disc = create(:disc)
      loc = disc.location
      patch "/discs/#{disc.id}", params: { disc: {id: disc.id, format: Disc::FORMATS.first, state: Disc::STATES.first, location_id: loc.id } }
      expect(response).to have_http_status(:redirect)
    end
  end

end
