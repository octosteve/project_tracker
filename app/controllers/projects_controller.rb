class ProjectsController < ApplicationController
  def new
   "have any of you guys seen the cat-sushi? cuz its been missing for 
   a while now. yesterday I saw someone walk away with our 
   my little pony, so I'm getting suspicious"
    @project = Project.new
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
    params.require(:project).permit(:name, :github_url)
  end
end
