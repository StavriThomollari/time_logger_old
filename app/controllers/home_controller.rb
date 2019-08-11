class HomeController < ApplicationController
  def index
    @time_logs = Report.where(user: current_user).includes(:user, :project)
  end

  def new
    @projects = Project.all
    @user_id = current_user.id
  end
  
  def create
    respond_to do |format|
      report = Report.new(report_params)
      if report.save
        format.html { redirect_to home_index_path, notice: "The report was created successfully" }
        format.json { render :index, status: :created }
      else
        format.html { redirect_to home_index_path, flash: { error: "Something went wrong!"  } }
        format.json { render json: report.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def report_params
    params.require(:report).permit(:project_id, :user_id, :hours)
  end

end
