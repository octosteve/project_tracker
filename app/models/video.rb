class Video < ActiveRecord::Base
  belongs_to :project

  def get_youtube_id
    /\?v=(.*)/.match(self.url)[1]
  end
end
