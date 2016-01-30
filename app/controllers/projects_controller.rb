class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def show
    project = Project.find(params[:id])
    @project_analyser = ProjectAnalyser.new(project)
  end

  def create
    @project = current_account.projects.new(project_params)
    if @project.setup!
      redirect_to @project
    else
      render :new
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :github_url, :heroku_url)
  end
end
