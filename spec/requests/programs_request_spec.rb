require 'rails_helper'

RSpec.describe "Programs", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/programs"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      program = create(:program)
      get "/programs/#{program.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/programs/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      program = create(:program)
      get "/programs/#{program.id}/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "returns http redirect" do
      create(:series)
      post "/programs", params: { program: { name: 'Angry Red Planet' } }
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "PATCH /update" do
    it "returns http redirect" do
      create(:series)
      program = create(:program)
      patch "/programs/#{program.id}", params: { program: {id: program.id, name: 'Red Planet Mars' } }
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "DELETE /destory" do
    it "returns http redirect" do
      program = create(:program)
      delete "/programs/#{program.id}"
      expect(response).to have_http_status(:redirect)
    end
  end

end
