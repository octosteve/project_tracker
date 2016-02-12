class VideosController < ApplicationController
  def create
    project = Project.find(video_params[:project_id])
    video = Video.new(video_params)
    if video.save
      project.videos << video
      project.save 
      binding.pry
      redirect_to project_path(project)
    end
  end

  private
  def video_params
    params.require(:video).permit(:url, :project_id)  
  end
end
