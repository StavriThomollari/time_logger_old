require 'rails_helper'

RSpec.feature "Authentificates", type: :request do
  describe "POST /" do
    it "returns the Authorization token" do
      u = create(:user, email: "stavrithomollari@outlook.com", password: "f0d79d58", password_confirmation: "f0d79d58")
      post api_authenticate_path, params: { credentials: {email: u.email, password: u.password} }, as: :json
      expect(response).to have_http_status(:success)
      json_response = JSON.parse(response.body)
      expect(json_response["email"]).not_to be_empty
      expect(json_response["auth_token"]).not_to be_empty
    end
  end
end
