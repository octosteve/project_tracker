class ProjectsController < ApplicationController
  def new
    @project = Project.new
    "!!!!!!"
  end

  def something_else
    "hello?"
  end

  def create
    @hi = "hey??"

    @project = Project.new(project_params)
    if @project.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :github_url, :heroku_url)
  end
end
