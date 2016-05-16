class ProjectDecorator < SimpleDelegator


  def screenshot_taken_at
    taken_at = screenshot.split("-")[-4..-1].join("-")
    taken_at.slice!('.png')
    taken_at.to_datetime.strftime("%A, %d %b %Y %l:%M %p")
  end
end
