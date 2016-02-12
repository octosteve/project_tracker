class ProjectDecorator < Draper::Decorator
  delegate_all

  def video_timestamp
    self.videos.last.created_at.strftime("%B %d, %Y")
  end

  def has_videos?
    !self.videos.empty?
  end

  def latest_youtube_id
    last_vid = self.videos.last
    /\?v=(.*)/.match(last_vid.url)[1]
  end
end