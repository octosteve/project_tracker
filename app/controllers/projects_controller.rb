class ProjectsController < ApplicationController
  before_action :load_cohort
  before_action :verify_project_owner, only: [:edit, :update, :destroy]

  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
    @project_analyser = ProjectAnalyser.new(@project)
  end

  def create
    @project = current_account.projects.new(project_params)
    @project.cohort = @cohort

    if @project.setup!
      redirect_to [@cohort, @project]
    else
      render "cohorts/show"
    end
  end

  def edit
    @project = current_account.projects.find(params[:id])
  end

  def update
    @project = current_account.projects.find(params[:id])
    if @project.update(project_params)
      redirect_to [@cohort, @project]
    else
      render :edit
    end
  end

  def destroy
    @project.remove!
    redirect_to @cohort, notice: "Your project has been deleted"
  end

  private

  def project_params
    params.require(:project).permit(:name, :github_url, :heroku_url)
  end

  def load_cohort
    @cohort = Cohort.find(params[:cohort_id])
  end

  def verify_project_owner
    @project = current_account.projects.find(params[:id])

    rescue ActiveRecord::RecordNotFound
      redirect_to [@cohort, Project.find(params[:id])], alert: "Only the owner can do that"
  end
end
