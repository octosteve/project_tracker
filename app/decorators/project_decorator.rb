class ProjectDecorator < Draper::Decorator
  delegate_all

  def video_uploaded_at
    self.videos.last.created_at.strftime("%B %d, %Y")
  end
end