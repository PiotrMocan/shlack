require 'rails_helper'

RSpec.describe "UserExports", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/user_exports/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/user_exports/create"
      expect(response).to have_http_status(:success)
    end
  end

end
