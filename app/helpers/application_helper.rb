module ApplicationHelper
  def active_menu(path)
    if path.is_a? Array
      'active' if path.include? request.fullpath
    else
      'active' if request.fullpath == path
    end
  end
end
