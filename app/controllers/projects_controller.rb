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

  def take_screenshot
    @project = Project.find(params[:id])
    path = Rails.root.join('app', 'assets', 'javascripts', 'screenshot.js')
    url = @project.heroku_url
    screenshot = @project.github_url.split("/").last
    binding.pry
    Dir.chdir(Rails.root.join('public', 'images'))
    puts Dir.pwd
    binding.pry
    system "phantomjs #{path} #{url} #{screenshot}"
    @project.screenshot = "#{screenshot}.png"
    @project.save

    respond_to do |format|
      format.html
      format.js { }
    end
    
  end

  private

  def project_params
    params.require(:project).permit(:name, :github_url, :heroku_url)
  end
end
