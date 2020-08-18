require 'rails_helper'

RSpec.describe "AlternateTitles", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/alternate_titles"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      create(:program)
      get "/alternate_titles/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "returns http redirect" do
      post "/alternate_titles", params: { alternate_title: { name: "The Man With X-ray Eyes", program_id: create(:program).id } }
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      alternate = create(:alternate_title)
      get "/alternate_titles/#{alternate.id}"
      expect(response).to have_http_status(:success)
    end
  end

end
