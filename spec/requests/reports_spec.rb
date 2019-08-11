require 'rails_helper'
require 'support/request_helper'

RSpec.describe "Reports", type: :request do
  describe "GET /reports" do
    it "returns http success and JSON body response contains expected reports attributes" do
      u = create(:user, email: "stavrithomollari@outlook.com", password: "f0d79d58", password_confirmation: "f0d79d58")
      r = create(:report, user: u)
      get api_reports_path, headers: RequestHelper.auth_headers(u)
      json_response = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(json_response.keys).to match_array([r.project.name])
      expect(json_response.values[0].keys).to match_array(["TotalHoursReported", "FirstReportDate", "LastReportDate"])
      expect(json_response.values[0]["TotalHoursReported"].to_i).to eql(r.hours.to_i)
    end
  end

  describe "POST /" do
    it "returns http success" do
      u = create(:user, email: "stavrithomollari@outlook.com", password: "f0d79d58", password_confirmation: "f0d79d58")
      p = create(:project)
      r = build(:report, user: u, project: p)
      before_count = Report.count
      post api_path, params: { "project_id": p.id, "hours": r.hours }, as: :json, headers: RequestHelper.auth_headers(u)
      expect(response).to have_http_status(:success)
      expect(Report.count).to eq(before_count + 1)
    end
  end

end
