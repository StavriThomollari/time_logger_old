class Api::ReportController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authorize_user

  def index
    reports = Report.joins(:project)
                    .group("projects.name")
                    .pluck("projects.name, 
                             SUM(reports.hours),
                             MIN(reports.created_at),
                             MAX(reports.created_at)")
    result = {}
    reports.each do |report|
      result[report[0]] = {
        "TotalHoursReported" => report[1],
        "FirstReportDate" => report[2],
        "LastReportDate" => report[3]
      }
    end
    render json: result
  end

  def create
    report = Report.new(report_params.except(:email))
    report.user = @current_user
    report.save!
    head :no_content 
  end

  private

  def report_params
  	params.permit(:project_id, :email, :hours)
  end

  def authorize_user
		@current_user = AuthorizeUserService.new(request.headers).authorize
		render json: "Invalid credentials!" unless @current_user.present?
	end

end