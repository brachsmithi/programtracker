require 'rails_helper'

RSpec.describe "Persons", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/persons"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      person = create(:person)
      get "/persons/#{person.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/persons/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      person = create(:person)
      get "/persons/#{person.id}/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "returns http redirect" do
      post "/persons", params: { person: { name: 'Francis Ford Coppola' }, person_aliases_attributes: { "1": {name: 'Francis Coppola'} } }
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "PATCH /update" do
    it "returns http redirect" do
      person = create(:person)
      patch "/persons/#{person.id}", params: { person: { name: 'Francis Ford Coppola' }, person_aliases_attributes: { "232324": {name: 'Francis Coppola'} } }
    end
  end

  describe "DELETE /destory" do
    it "returns http redirect" do
      person = create(:person)
      delete "/persons/#{person.id}"
      expect(response).to have_http_status(:redirect)
    end
  end

end
