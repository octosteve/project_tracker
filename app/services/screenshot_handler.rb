class ScreenshotHandler


  PATH_TO_PHANTOM_SCRIPT = Rails.root.join('app', 'assets', 'javascripts', 'screenshot.js')
  @@screenshot_filename = nil
  
  def self.get_and_save_screenshot(project)
    set_screenshot_filename(project)
    Dir.chdir(Rails.root.join('public', 'images'))
    remove_old_screenshot(project)
    system "phantomjs #{PATH_TO_PHANTOM_SCRIPT} #{project.heroku_url} #{self.screenshot_filename}"
    project.update(screenshot: self.screenshot_filename)
  end

  def self.set_screenshot_filename(project)
    @@screenshot_filename = "#{project.github_url.split("/").last}-#{Time.now}.png".split(" ")[0..-2].join("-") << ".png"
  end

  def self.screenshot_filename
    @@screenshot_filename
  end

  def self.remove_old_screenshot(project)
    project_name = project.github_url.split("/").last
    old_screenshot = Dir.entries(".").detect {|f| f.include?(project_name)}
    File.delete(old_screenshot) if old_screenshot
  end
end