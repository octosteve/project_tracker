class ProjectsController < ApplicationController
  before_action :load_cohort
  before_action :load_project, only: [:show, :edit, :update]
  def index
    @projects = Project.all
  end

  def show
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
  end

  def update
    if @project.update(project_params)
      redirect_to [@cohort, @project]
    else
      render :edit
    end

  end

  private

  def project_params
    params.require(:project).permit(:name, :github_url, :heroku_url)
  end

  def load_cohort
    @cohort = Cohort.find(params[:cohort_id])
  end

  def load_project
    @project = Project.find(params[:id])
  end
end
