require 'rails_helper'

RSpec.describe "ProgramVersionClusters", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/program_version_clusters"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      pvc = create(:program_version_cluster)
      get "/program_version_clusters/#{pvc.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/program_version_clusters/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      pvc = create(:program_version_cluster)
      get "/program_version_clusters/#{pvc.id}/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
