require 'rails_helper'

RSpec.describe "Series", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/series"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      series = create(:series)
      get "/series/#{series.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/series/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      series = create(:series)
      get "/series/#{series.id}/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "returns http redirect" do\
      post "/series", params: { series: { name: 'MCU' } }
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "PATCH /update" do
    it "returns http redirect" do
      series = create(:series)
      patch "/series/#{series.id}", params: { series: {id: series.id, name: 'M. Hulot' } }
      expect(response).to have_http_status(:redirect)
    end
  end

end
